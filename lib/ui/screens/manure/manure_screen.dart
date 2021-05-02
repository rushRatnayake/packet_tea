import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:packet_tea/bloc/core/manure/manure/manure_bloc.dart';
import 'package:packet_tea/bloc/core/manure/manure_request/manure_request_bloc.dart';
import 'package:packet_tea/data/models/manure_model.dart';
import 'package:packet_tea/ui/screens/common_widgets/generic_error_message.dart';
import 'package:packet_tea/ui/screens/common_widgets/no_items_widget.dart';
import 'package:packet_tea/ui/screens/manure/add_manure_form.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

class ManureScreen extends StatelessWidget {
  const ManureScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _createBlocProviders(context),
      child: Builder(
        builder: (context) {
          return Scaffold(
              body: Scrollbar(
                child: SingleChildScrollView(
                    child: Container(
                        width: double.infinity, child: _buildChild(context))),
              ),
              floatingActionButton: _buildFloatingButton(context));
        },
      ),
    );
  }

  List<BlocProvider> _createBlocProviders(final BuildContext context) {
    return [
      BlocProvider<ManureBloc>(
        create: (context) {
          final bloc = ManureBloc();
          bloc.add(ManureFetchEvent());
          return bloc;
        },
      ),
    ];
  }

  Widget _buildChild(BuildContext context) {
    return BlocBuilder<ManureBloc, ManureState>(
      cubit: BlocProvider.of<ManureBloc>(context),
      builder: (BuildContext context, ManureState state) {
        if (state is ManureInitial || state is ManureInProgressState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ManureSuccessState) {
          if (state.manure.manures.isEmpty) {
            return NoItemsToShowMessageWidget(
              message: "No Manure Requests",
            );
          } else {
            return Column(
              children: [
                _buildTotal(context, state.manure.totalManure,
                    state.manure.totalManureAmount),
                _buildList(context, state.manure.manures)
              ],
            );
          }
        } else {
          assert(state is ManureFailedState);
          return GenericErrorMessageWidget();
        }
      },
    );
  }

  Widget _buildTotal(BuildContext context, String total, String amount) {
    return BlocBuilder<ManureBloc, ManureState>(
      cubit: BlocProvider.of<ManureBloc>(context),
      buildWhen: (previous,current)=> previous!=current,
      builder: (BuildContext context, ManureState state) {
        if (state is ManureSuccessState) {
          if (state.manure.manures.isEmpty) {
            return NoItemsToShowMessageWidget(
              message: "No Manure Requests",
            );
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0, color: AppColors.appGreen2.withOpacity(0.3))
                ],
                color: AppColors.appGreen1.withOpacity(0.9),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Manure Requested ",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: AppColors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "$total KG",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: AppColors.white),
                      )
                    ],
                  ),
                  Icon(
                    Icons.line_style,
                    size: 50,
                    color: AppColors.white,
                  )
                ],
              ),
            );
          }
        } else {
          assert(state is ManureFailedState);
          return GenericErrorMessageWidget();
        }
      },
    );


  }

  Widget _buildList(BuildContext context, List<ManureModel> manure) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
          child: Text(
            "Manure Requests List",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: AppColors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: ListView.separated(
            itemCount: manure.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => _listItem(context, manure[index]),
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => const SizedBox(height: 5),
          ),
        )
      ],
    );
  }

  Widget _listItem(BuildContext context, ManureModel manure) {
   return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: <Widget>[
          if (manure.status == 'pending') ...[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                context.read<ManureBloc>().add(
                  ManureDeleteEvent(deleteItemId: manure.id),
                );
              },
            ),
          ]
        ],
        child: InkWell(
          child: Container(
            padding: EdgeInsets.only(left: 8),
            color: manure.status == 'pending'
                ? AppColors.darkYellow
                : manure.status == 'accepted'
                ? AppColors.green
                : AppColors.red,
            child: Container(
                color: AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${manure.weight} KG",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(letterSpacing: 1),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${manure.contactPerson} - ${manure.contactNumber}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(letterSpacing: 1),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              manure.status == 'pending'
                                  ? "Pending"
                                  : manure.status == 'accepted'
                                  ? "Approved"
                                  : "Rejected",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                  letterSpacing: 1, color: AppColors.grey),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "${manure.type}".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(letterSpacing: 1, color: AppColors.grey),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                )),
          ),
        ),
      );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: IconButton(
        onPressed: () => {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return BlocProvider<ManureRequestBloc>(
              create: (_) => ManureRequestBloc(),
              child: AddManureForm(),
            );
          }))
        },
        icon: Icon(Icons.add),
        color: AppColors.white,
      ),
      backgroundColor: AppColors.appGreen1,
    );
  }
}
