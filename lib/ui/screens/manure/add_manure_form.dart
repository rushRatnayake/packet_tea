import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packet_tea/ui/screens/common_widgets/app_button.dart';
import 'package:packet_tea/ui/screens/common_widgets/custom_scaffold.dart';
import 'package:packet_tea/ui/themes/app_theme_data.dart';

class AddManureForm extends StatefulWidget{
  @override
  _AddManureFormState createState() => _AddManureFormState();
}

class _AddManureFormState extends State<AddManureForm> {
  int _groupValue = -1;

  @override
  Widget build(BuildContext context) {
    return CustomizedScaffold(
        title: "Add Manure",
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
        _buildWeightWidget(context),
        SizedBox(height: 20,),
        _buildContactPerson(context),
        SizedBox(height: 20,),
        Text("Select Manure Type", textAlign: TextAlign.left, style: Theme.of(context).textTheme.bodyText1,),
        SizedBox(height: 10,),
        _buildTypes(context)
      ],
    );
  }

  Widget _buildWeightWidget(BuildContext context){
    return TextFormField(
      key: const Key("forgot_form_password_field_key"),
      initialValue: "",
      autocorrect: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: (value) {},
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: lightModeInputDecoration().copyWith(
        labelText: "Weight",
        hintText: "Enter Manure Weight",
        hasFloatingPlaceholder: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  Widget _buildContactPerson(BuildContext context){
    return TextFormField(
      key: const Key("forgot_form_contact_person_field_key"),
      initialValue: "",
      autocorrect: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      onChanged: (value) {},
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: lightModeInputDecoration().copyWith(
        labelText: "Contact Person",
        hintText: "Enter Contact Number",
        hasFloatingPlaceholder: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  Widget _buildTypes(BuildContext context){
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: RadioListTile(
            value: 0,
            groupValue: _groupValue,
            title: Text("CIC"),
            onChanged: (newValue) =>
                setState(() => _groupValue = newValue),
            selected: false,
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile(
            value: 1,
            groupValue: _groupValue,
            title: Text("Baur"),
            onChanged: (newValue) =>
                setState(() => _groupValue = newValue),
            selected: false,
          ),
        ),
      ],
    );
  }
}