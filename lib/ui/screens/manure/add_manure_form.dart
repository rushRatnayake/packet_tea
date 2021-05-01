import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:packet_tea/bloc/core/login/login_bloc.dart';
import 'package:packet_tea/bloc/core/manure/manure/manure_bloc.dart';
import 'package:packet_tea/bloc/core/manure/manure_request/manure_request_bloc.dart';
import 'package:packet_tea/ui/screens/common_widgets/app_button.dart';
import 'package:packet_tea/ui/screens/common_widgets/custom_scaffold.dart';
import 'package:packet_tea/ui/screens/common_widgets/loader.dart';
import 'package:packet_tea/ui/themes/app_theme_data.dart';

class AddManureForm extends StatefulWidget {
  @override
  _AddManureFormState createState() => _AddManureFormState();
}

class _AddManureFormState extends State<AddManureForm> {
  String _groupValue = "CIC";

  @override
  Widget build(BuildContext context) {
    return CustomizedScaffold(
        title: "Add Manure",
        description: "Fill the form to request for manure",
        onBackButtonPressed: Navigator.of(context).pop,
        bottomActionButton: _buildNextButton(context),
        child: _buildChildren(context));
  }

  Widget _buildNextButton(BuildContext context) {
    return BlocBuilder<ManureRequestBloc, ManureRequestState>(
      builder: (context, state) {
        return Container(
          child: AppButton(
            text: "Save",
            disabled: state.weightField.invalid || state.contactField.invalid || state.contactNameField.invalid,
            onPressed: () {
              context.read<ManureRequestBloc>().add(
                    ManureRequestSubmitted(),
                  );
            },
          ),
        );
      },
    );
  }

  Widget _buildChildren(BuildContext context) {
    return BlocConsumer<ManureRequestBloc, ManureRequestState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == FormzStatus.submissionInProgress) {
            Loader.show(status: "Requesting Manure");
          } else if (state.status == FormzStatus.submissionSuccess) {
            Loader.hide();
            Navigator.of(context).pop();
          } else if (state.status == FormzStatus.submissionFailure) {
            Loader.error(error: "Manure Request Failed");
          } else {
            Loader.hide();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              _buildWeightWidget(context),
              SizedBox(
                height: 20,
              ),
              _buildContactPerson(context),
              SizedBox(
                height: 20,
              ),
              _buildContactNumber(context),
              SizedBox(
                height: 20,
              ),
              Text(
                "Select Manure Type",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 10,
              ),
              _buildTypes(context)
            ],
          );
        },
      );
  }

  Widget _buildWeightWidget(BuildContext context) {
    return BlocBuilder<ManureRequestBloc, ManureRequestState>(
      buildWhen: (previous, current) =>
          previous.weightField != current.weightField,
      builder: (context, state) {
        return TextFormField(
          key: const Key("manure_request_weight_field_key"),
          initialValue: state.weightField.value,
          autocorrect: false,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            context.read<ManureRequestBloc>().add(
                  ManureWeightChanged(weight: value),
                );
          },
          decoration: lightModeInputDecoration().copyWith(
            labelText: "Weight",
            hintText: "Enter Manure Weight",
            hasFloatingPlaceholder: true,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            errorText: state.weightField.getErrorMessageIfExists(),

          ),
        );
      },
    );
  }

  Widget _buildContactPerson(BuildContext context) {
    return BlocBuilder<ManureRequestBloc, ManureRequestState>(
      buildWhen: (previous, current) =>
          previous.contactNameField != current.contactNameField,
      builder: (context, state) {
        return TextFormField(
          key: const Key("manure_request_contact_name_field_key"),
          initialValue: state.contactNameField.value,
          autocorrect: false,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            print(value);
            context.read<ManureRequestBloc>().add(
              ManureContactNameChanged(contactNameField: value),
            );
          },
          decoration: lightModeInputDecoration().copyWith(
            labelText: "Contact Name",
            hintText: "Enter Contact Name",
            hasFloatingPlaceholder: true,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            errorText: state.contactNameField.getErrorMessageIfExists(),
          ),
        );
      },
    );
  }

  Widget _buildContactNumber(BuildContext context) {
    return BlocBuilder<ManureRequestBloc, ManureRequestState>(
      buildWhen: (previous, current) =>
          previous.contactField != current.contactField,
      builder: (context, state) {
        return TextFormField(
          key: const Key("manure_request_contact_field_key"),
          initialValue: state.contactField.value,
          autocorrect: false,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            context.read<ManureRequestBloc>().add(
                  ManureContactChanged(contactField: value),
                );
          },
          decoration: lightModeInputDecoration().copyWith(
            labelText: "Contact Number",
            hintText: "Enter Contact Number",
            hasFloatingPlaceholder: true,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            errorText: state.contactField.getErrorMessageIfExists(),
          ),
        );
      },
    );
  }

  Widget _buildTypes(BuildContext context) {
    return BlocBuilder<ManureRequestBloc, ManureRequestState>(
      buildWhen: (previous, current) => previous.typeField != current.typeField,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: RadioListTile(
                value: "cic",
                groupValue: _groupValue,
                title: Text("CIC"),
                onChanged: (newValue) {
                  setState(() => _groupValue = newValue);
                  context.read<ManureRequestBloc>().add(
                        ManureTypeChanged(typeField: newValue),
                      );
                },
                selected: false,
              ),
            ),
            Expanded(
              flex: 1,
              child: RadioListTile(
                value: "baur",
                groupValue: _groupValue,
                title: Text("Baur"),
                onChanged: (newValue) {
                  setState(() => _groupValue = newValue);
                  context.read<ManureRequestBloc>().add(
                        ManureTypeChanged(typeField: newValue),
                      );
                },
                selected: false,
              ),
            ),
          ],
        );
      },
    );
  }
}
