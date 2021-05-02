import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packet_tea/bloc/core/estate/estate_bloc.dart';
import 'package:packet_tea/bloc/core/home/home_cubit.dart';
import 'package:packet_tea/data/models/dashboard_model.dart';
import 'package:packet_tea/data/services/shared_preferences_services.dart';
import 'package:packet_tea/ui/screens/common_widgets/generic_error_message.dart';
import 'package:packet_tea/ui/screens/common_widgets/no_items_widget.dart';
import 'package:packet_tea/ui/screens/home/home_screen.dart';
import 'package:packet_tea/ui/screens/home/home_screen_view.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

class HomeEstateSelector extends StatefulWidget{

  @override
  _HomeEstateSelectorState createState() => _HomeEstateSelectorState();
}

class _HomeEstateSelectorState extends State<HomeEstateSelector> {

  final SharedPreferenceService _sp = SharedPreferenceService();

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _createBlocProviders(context),
      child: Builder(
        builder: (context) {
          return _buildChild(context);
        },
      ),
    );
  }

  Widget _buildLocations(BuildContext context, EstateModel estate) {
    return InkWell(
      onTap:(){
        _onEstateChange(estate.id,estate.name);
      },
      child: Container(
        padding: EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 10.0, right: 20),
              child: Icon(
                Icons.apartment,
                size: 25,
                color: AppColors.appGreen1,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "${estate.name}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                if (estate.address != null && estate.address != "") ...[
                  Text(estate.address,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 14, color: AppColors.grey)),

                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<BlocProvider> _createBlocProviders(final BuildContext context) {
    return [
      BlocProvider<EstateBloc>(
        create: (context) {
          final bloc = EstateBloc();
          bloc.add(EstatesFetchEvent());
          return bloc;
        },
      ),
    ];
  }

  Widget _buildChild(BuildContext context){

    return BlocBuilder<EstateBloc, EstateState>(
      cubit: BlocProvider.of<EstateBloc>(context),
      builder: (BuildContext context, EstateState state) {
        if (state is EstateInitial || state is EstateInProgress) {
          return Center(child: CircularProgressIndicator());
        } else if (state is EstateSuccess) {
          if (state.estates.isEmpty) {
            return Container(
              child: Text(
                "Error Fetching Estates"
              ),
            );
          } else {
            return Container(
              color: AppColors.background,
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 5),
                    Text("Select Tea Estate",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 15),
                    _buildList(context, state.estates),
                    SizedBox(height: 15),

                  ],
                ),
              ),
            );
          }
        } else {
          assert(state is EstateFailed);
          return GenericErrorMessageWidget();
        }
      },
    );


  }

  Widget _buildList(BuildContext context, List<EstateModel> estates){
    return Container(
      child: ListView.separated(
        itemCount: estates.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildLocations(context, estates[index]),
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) => Divider(
          thickness: 2.0,
        ),
      ),
    );

  }

  Future<void> _onEstateChange(String id, String name) async{
    await _sp.setEstateID(id);
    await  _sp.setEstateName(name);
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      Future.delayed(
        Duration(),
            () => context.read<HomeCubit>().changeHomeScreenViewTo
          (HomeScreenView.home),
      );
      return HomePage();
    }));
  }
}
