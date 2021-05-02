import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jiffy/jiffy.dart';
import 'package:packet_tea/bloc/core/loan/loan_request_bloc/loan_request_bloc.dart';
import 'package:packet_tea/bloc/core/loan/loans/loans_bloc.dart';
import 'package:packet_tea/data/models/loan_model.dart';
import 'package:packet_tea/ui/screens/common_widgets/generic_error_message.dart';
import 'package:packet_tea/ui/screens/common_widgets/no_items_widget.dart';
import 'package:packet_tea/ui/screens/loans/add_loan_form.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

class LoanScreen extends StatelessWidget{
  const LoanScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _createBlocProviders(context),
      child: Builder(
        builder: (context) {
          return Scaffold(
              body: Scrollbar(child: SingleChildScrollView(child: Container(width: double.infinity, child: _buildChild(context))),),
              floatingActionButton: _buildFloatingButton(context));
        },
      ),
    );
  }

  List<BlocProvider> _createBlocProviders(final BuildContext context) {
    return [
      BlocProvider<LoansBloc>(
        create: (context) {
          final bloc = LoansBloc();
          bloc.add(LoansFetchEvent());
          return bloc;
        },
      ),
    ];
  }

  Widget _buildChild(BuildContext context) {
    return BlocBuilder<LoansBloc, LoansState>(
      cubit: BlocProvider.of<LoansBloc>(context),
      builder: (BuildContext context, LoansState state) {
        if (state is LoansInitial || state is LoansInProgressState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoansSuccessState) {
          if (state.loans.loan.isEmpty){
            return NoItemsToShowMessageWidget(
              message: "No Loan Request",
            );
          }else{
            return Column(
              children: [_buildTotal(context, state.loans.totalLoan), _buildList(context, state.loans.loan)],
            );
          }
        } else {
          assert(state is LoansFailedState);
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
                "Total Loans Requested ",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                "$total LKR",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: AppColors.white),
              )
            ],
          ),
          Icon(
            Icons.monetization_on_outlined,
            size: 50,
            color: AppColors.white,
          )
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List<LoanModel> loans) {
    return BlocBuilder<LoansBloc, LoansState>(
      cubit: BlocProvider.of<LoansBloc>(context),
      buildWhen: (previous,current)=> previous != current,
      builder: (BuildContext context, LoansState state) {
        if (state is LoansInitial || state is LoansInProgressState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoansSuccessState) {
          if (state.loans.loan.isEmpty){
            return NoItemsToShowMessageWidget(
              message: "No Loan Request",
            );
          }else{
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                  padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  child: Text(
                    "Loan Requests List",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: ListView.separated(
                    itemCount: loans.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => _listItem(context, loans[index]),
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => const SizedBox(height: 5),),
                )
              ],
            );
          }
        } else {
          assert(state is LoansFailedState);
          return GenericErrorMessageWidget();
        }
      },
    );
  }

  Widget _listItem(BuildContext context, LoanModel loan){
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        if (loan.status == 'pending') ...[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              context.read<LoansBloc>().add(
                LoansDeleteEvent(deleteItemId: loan.id),
              );
            },
          ),
        ]
      ],
      child: Container(
        padding: EdgeInsets.only(left: 5),
        color: loan.status == 'pending'? AppColors.darkYellow :  loan.status == 'approved'? AppColors.green :AppColors.red,
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
                          "${loan.amount} LKR",
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
                          Jiffy(loan.dateTime).format('yyyy-MM-dd'),
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
                          loan.status == 'pending'? "Pending" :  loan.status == 'approved'? "Approved" : "Rejected",
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    loan.status == 'pending'? Icons.pending_outlined :  loan.status == 'approved'? Icons.done :Icons.cancel_outlined,
                    size: 30,
                    color: loan.status == 'pending'? AppColors.darkYellow :  loan.status == 'approved'? AppColors.green :AppColors.red,
                  ),
                )
              ],
            )),
      ),
    );

  }
  Widget _buildFloatingButton(BuildContext context){
    return FloatingActionButton(
      child: IconButton(
        onPressed: () => {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return BlocProvider<LoanRequestBloc>(
              create: (_) => LoanRequestBloc(),
              child: AddLoadForm(),
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