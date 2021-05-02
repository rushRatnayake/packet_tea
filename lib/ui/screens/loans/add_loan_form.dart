import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jiffy/jiffy.dart';
import 'package:packet_tea/bloc/core/home/home_cubit.dart';
import 'package:packet_tea/bloc/core/loan/loan_request_bloc/loan_request_bloc.dart';
import 'package:packet_tea/ui/screens/common_widgets/app_button.dart';
import 'package:packet_tea/ui/screens/common_widgets/custom_scaffold.dart';
import 'package:packet_tea/ui/screens/common_widgets/loader.dart';
import 'package:packet_tea/ui/screens/home/home_screen.dart';
import 'package:packet_tea/ui/screens/home/home_screen_view.dart';
import 'package:packet_tea/ui/screens/util/custom_text_editing_controller.dart';
import 'package:packet_tea/ui/themes/appColors.dart';
import 'package:packet_tea/ui/themes/app_theme_data.dart';

class AddLoadForm extends StatefulWidget{
  @override
  _AddLoadFormState createState() => _AddLoadFormState();
}

class _AddLoadFormState extends State<AddLoadForm> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _loanDateController;
  FocusNode _loanDateFocusNode;
  DateTime _lastDate;

  DateTime _currentlySelectedArrivalDate;

  DateTime _initialArrivalDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._currentlySelectedArrivalDate  = this._initialArrivalDate = DateTime.now();
    _loanDateController = CustomTextEditingController();
    _loanDateFocusNode = FocusNode();
    this._lastDate = Jiffy(DateTime.now()).add(years: 1);
  }
  @override
  Widget build(BuildContext context) {
    return CustomizedScaffold(
        title: "Add Loan",
        description:"Fill the form to request for a loan",
        onBackButtonPressed: Navigator.of(context).pop,
        bottomActionButton: _buildNextButton(context),
        child: _buildChildren(context));
  }

  Widget _buildNextButton(BuildContext context) {
    return BlocBuilder<LoanRequestBloc, LoanRequestState>(
      builder: (context, state) {
        return Container(
          child: AppButton(
            text: "Save",
            disabled: state.loanAmountField.invalid || state.loanNotesField.invalid || state.loanDateField.invalid,
            onPressed: () {
              context.read<LoanRequestBloc>().add(
                LoanRequestSubmitted(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildChildren(BuildContext context){
    return BlocConsumer<LoanRequestBloc, LoanRequestState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          Loader.show(status: "Requesting Loan");
        } else if (state.status == FormzStatus.submissionSuccess) {
          Loader.hide();
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            Future.delayed(
              Duration(),
                  () => context.read<HomeCubit>().changeHomeScreenViewTo
                (HomeScreenView.loan),
            );
            return HomePage();
          }));
        } else if (state.status == FormzStatus.submissionFailure) {
          Loader.error(error: "Loan Request Failed");
        } else {
          Loader.hide();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            _buildLoanAmountWidget(context),
            SizedBox(height: 20,),
            _buildLoanNotesWidget(context),
            SizedBox(height: 20,),
            _buildDatePicker(context),
            SizedBox(height: 10,),
          ],
        );
      },
    );
  }

  Widget _buildLoanAmountWidget(BuildContext context){
    return BlocBuilder<LoanRequestBloc, LoanRequestState>(
      buildWhen: (previous, current) =>
      previous.loanAmountField.value != current.loanAmountField.value,
      builder: (context, state) {
        return TextFormField(
          key: const Key("add_loan_form_amount_key"),
          initialValue: state.loanAmountField.value,
          autocorrect: false,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            context.read<LoanRequestBloc>().add(
              LoanAmountChanged(loanAmount: value),
            );
          },
          decoration: lightModeInputDecoration().copyWith(
            labelText: "Loan Amount",
            hintText: "Enter loan amount",
            prefixIcon: const Icon(Icons.monetization_on_outlined, color: AppColors.appGreen1,),
            hasFloatingPlaceholder: true,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            errorText: state.loanAmountField.getErrorMessageIfExists(),

          ),
        );
      },
    );
  }

  Widget _buildLoanNotesWidget(BuildContext context) {

    return BlocBuilder<LoanRequestBloc, LoanRequestState>(
      buildWhen: (previous, current) =>
      previous.loanNotesField.value != current.loanNotesField.value,
      builder: (context, state) {
        return TextFormField(
          key: const Key("add_loan_form_notes_key"),
          initialValue: state.loanNotesField.value,
          autocorrect: false,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            context.read<LoanRequestBloc>().add(
              LoanNotesChanged(notes: value),
            );
          },
          decoration: lightModeInputDecoration().copyWith(
            labelText: "Notes",
            hintText: "Add a note",
            prefixIcon: const Icon(Icons.notes, color: AppColors.appGreen1,),
            hasFloatingPlaceholder: true,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            errorText: state.loanNotesField.getErrorMessageIfExists(),
          ),
        );
      },
    );

  }

  Widget _buildDatePicker(BuildContext context){
    return BlocConsumer<LoanRequestBloc, LoanRequestState>(
      cubit: BlocProvider.of<LoanRequestBloc>(context),
      listenWhen: (previous,current)=>previous.loanDateField.value != current.loanDateField.value,
      listener: (context, state) {
        if (state.loanDateField.valid) {
          _loanDateController.text = Jiffy(state.loanDateField.value).format('dd-MM-yyyy');
          setState(() {
            _currentlySelectedArrivalDate = state.loanDateField.value;
          });
        } else {
          _loanDateController.text = "";
          setState(() => _currentlySelectedArrivalDate = _initialArrivalDate);
        }
      },
      builder: (context, state) {
        return Container(
          child: TextFormField(
              key: const Key(""),
              controller: _loanDateController,
              focusNode: _loanDateFocusNode,
              enableInteractiveSelection: false,
              autofocus: true,
              showCursor: true,
              readOnly: true,
              onTap: () async {
                var dateTime = await showDatePicker(
                  context: context,
                  initialDatePickerMode: DatePickerMode.day,
                  initialEntryMode: DatePickerEntryMode.calendar,
                  initialDate: _currentlySelectedArrivalDate,
                  firstDate: _initialArrivalDate,
                  lastDate: _lastDate,
                  helpText: "Select a Date".toUpperCase(),
                  errorInvalidText: "The date you entered is invalid",
                );
                context.read<LoanRequestBloc>().add(LoanDateChanged(loanDate: dateTime));
              },
              decoration: lightModeInputDecoration().copyWith(
                hintText: "Select Preferred Date",
                prefixIcon: const Icon(Icons.calendar_today_rounded, color: AppColors.appGreen1,),
                errorText: state.loanDateField.getErrorMessageIfExists(),
              ),
            ),
        );
      },
    );

  }

}