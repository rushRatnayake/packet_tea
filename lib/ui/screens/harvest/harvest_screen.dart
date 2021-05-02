import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packet_tea/bloc/core/harvest/harvest_bloc.dart';
import 'package:packet_tea/bloc/core/manure/manure_request/manure_request_bloc.dart';
import 'package:packet_tea/data/models/harvest_model.dart';
import 'package:packet_tea/ui/screens/common_widgets/generic_error_message.dart';
import 'package:packet_tea/ui/screens/common_widgets/no_items_widget.dart';
import 'package:packet_tea/ui/screens/manure/add_manure_form.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

class HarvestScreen extends StatelessWidget {
  const HarvestScreen({Key key}) : super(key: key);

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
              ),);
        },
      ),
    );
  }

  List<BlocProvider> _createBlocProviders(final BuildContext context) {
    return [
      BlocProvider<HarvestBloc>(
        create: (context) {
          final bloc = HarvestBloc();
          bloc.add(HarvestFetchEvent());
          return bloc;
        },
      ),
    ];
  }

  Widget _buildChild(BuildContext context) {
    return BlocBuilder<HarvestBloc, HarvestState>(
      cubit: BlocProvider.of<HarvestBloc>(context),
      builder: (BuildContext context, HarvestState state) {
        if (state is HarvestInitial || state is HarvestInProgressState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HarvestSuccessState) {
          if (state.harvest.harvests.isEmpty) {
            return NoItemsToShowMessageWidget(
              message: "No Manure Requests",
            );
          } else {
            return Column(
              children: [
                _buildTotal(context, state.harvest.totalHarvestWeight),
                _buildList(context, state.harvest.harvests)
              ],
            );
          }
        } else {
          assert(state is HarvestFailedState);
          return GenericErrorMessageWidget();
        }
      },
    );
  }

  Widget _buildTotal(BuildContext context, String total) {
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
                "Total Harvest ",
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
            Icons.grass,
            size: 40,
            color: AppColors.white,
          )
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List<HarvestModel> harvest) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
          child: Text(
            "Harvest Records",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: AppColors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: ListView.separated(
            itemCount: harvest.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => _listItem(context, harvest[index]),
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => const SizedBox(height: 5),
          ),
        )
      ],
    );
  }

  Widget _listItem(BuildContext context, HarvestModel harvest) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      color: harvest.status == 'pending'
          ? AppColors.darkYellow
          : harvest.status == 'rejected'
              ? AppColors.red
              : AppColors.green,
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
                        harvest.approvedWeight == "null" ? "No Approved Weight":"${harvest.approvedWeight} KG",
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
                        "Gross Weight : ${harvest.weight} KG",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(letterSpacing: 1,color: AppColors.grey),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "${harvest.createAt}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(letterSpacing: 1, color: AppColors.grey),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        harvest.status == 'pending'? "Pending" :  harvest.status == 'rejected'? "Rejected" : "Approved",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(letterSpacing: 1, color: AppColors.grey),
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
              if (harvest.amount != "null") ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "${harvest.amount} LKR".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(letterSpacing: 1, color: AppColors.grey),
                    textAlign: TextAlign.left,
                  ),
                )
              ]
            ],
          )),
    );
  }
}
