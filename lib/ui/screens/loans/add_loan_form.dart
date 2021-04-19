import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packet_tea/ui/screens/common_widgets/app_button.dart';
import 'package:packet_tea/ui/screens/common_widgets/custom_scaffold.dart';
import 'package:packet_tea/ui/themes/app_theme_data.dart';

class AddLoadForm extends StatefulWidget{
  @override
  _AddLoadFormState createState() => _AddLoadFormState();
}

class _AddLoadFormState extends State<AddLoadForm> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _tripDepartureController;
  FocusNode _tripDepartureTimeFocusNode;

  @override
  Widget build(BuildContext context) {
    return CustomizedScaffold(
        title: "Add Loan",
        description:"Fill the form to add manure",
        onBackButtonPressed: Navigator.of(context).pop,
        bottomActionButton: _buildNextButton(context),
        child: _buildChildren(context));
  }

  Widget _buildNextButton(BuildContext context) {
    return Container(
      child: AppButton(
        text: "Save",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildChildren(BuildContext context){
    return Column(
      children: [
        _buildLoanAmountWidget(context),
        SizedBox(height: 20,),
        _buildContactPerson(context),
        // SizedBox(height: 20,),
        _buildDatePicker(context),
        SizedBox(height: 10,),
      ],
    );
  }

  Widget _buildLoanAmountWidget(BuildContext context){
    return TextFormField(
      key: const Key("add_loan_form_amount_key"),
      initialValue: "",
      autocorrect: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: (value) {},
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: lightModeInputDecoration().copyWith(
        labelText: "Loan Amount",
        hintText: "Enter loan amount",
        hasFloatingPlaceholder: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  Widget _buildContactPerson(BuildContext context) {
    return TextFormField(
      key: const Key("add_loan_form_notes_key"),
      initialValue: "",
      autocorrect: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: (value) {},
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: lightModeInputDecoration().copyWith(
        labelText: "Notes",
        hintText: "Add a note",
        hasFloatingPlaceholder: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child:TextFormField(
          key: const Key("loan_form_date_field_key"),
          controller: _tripDepartureController,
          focusNode: _tripDepartureTimeFocusNode,
          enableInteractiveSelection: false,
          showCursor: true,
          readOnly: true,
          autofocus: true,
          onTap: _onTextFieldTapped,
          decoration:lightModeInputDecoration().copyWith(
            hintText: "Select Date",
            suffixIcon: const Icon(Icons.query_builder),
          ),
        ),
    );
  }

  Future<void> _onTextFieldTapped() async {
    var depTime = await showDatePicker(
      context: context,
      initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
  }
}