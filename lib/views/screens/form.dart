import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:pj_paul_ministries/model/apiController.dart';

class DynamicFields extends StatefulWidget {
  const DynamicFields(
      {super.key,
      required this.title,
      required this.apilink,
      required this.formFieldList});
  final String title;
  final String apilink;
  final List formFieldList;

  @override
  State<DynamicFields> createState() => _DynamicFieldsState();
}

class _DynamicFieldsState extends State<DynamicFields> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<Widget> fields = [];
  String savedValue = '';

  @override
  void initState() {
    super.initState();
    List formFieldList = widget.formFieldList;
    List<Widget> tempFormFieldList = [];
    formFieldList.forEach((element) {
      NewField fieldobj = NewField(
        name: element["name"],
        fieldType: element["fieldType"],
        label: element["label"],
        isRequired: element["isRequired"],
        options: element["options"],
      );
      tempFormFieldList.add(fieldobj);
    });
    setState(() {
      fields = tempFormFieldList;
    });
  }

  messageDialog(context, message, title, navigation) {
    print(message);

    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () => Future.value(false),
              child: AlertDialog(
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
                actions: [
                  ElevatedButton(
                    child: Text("Ok"),
                    onPressed: () {
                      if (navigation) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home', ModalRoute.withName('/home'));
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
                content: SingleChildScrollView(
                  child: Text(message),
                ),
              ));
        });
  }

  bool proceessData = false;
  submitData(Map insertData) async {
    setState(() {
      proceessData = true;
    });
    Map<String, String> jsonData = {};
    insertData.forEach((key, value) {
      jsonData[key.toString()] = value.toString();
    });

    ApiController apiobj = ApiController();
    HTTPCallResponse response =
        await apiobj.postCall(jsonData, "/${widget.apilink}");
    print("----${response.status}");

    switch (response.status) {
      case 500:
        {
          messageDialog(context, response.error!["errorMessage"],
              'Submission Failed', false);
        }
        break;
      case 404:
        {
          messageDialog(
              context,
              "Unable to connect server, Please check your internet.",
              'Sumission Failed',
              false);
        }
        break;
      case 200:
        {
          messageDialog(context, "Your request has been submitted successfully",
              'Successful', true);
        }
        break;
      default:
        {}
        break;
    }
    setState(() {
      proceessData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: FormBuilder(
              key: _formKey,
              // IMPORTANT to remove all references from dynamic field when delete
              clearValueOnUnregister: true,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Column(
                    children: List<Widget>.generate(
                        fields.length, (counter) => fields[counter]),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          color: Colors.red,
                          disabledColor: Colors.red.shade100,
                          child: proceessData
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator()),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Submitting..."),
                                  ],
                                )
                              : Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                ),
                          onPressed: proceessData
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    if (_formKey.currentState != null) {
                                      print(_formKey.currentState!.value);
                                      submitData(_formKey.currentState!.value);
                                    }
                                  }
                                },
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                ],
              ),
            ),
          ),
        ));
  }
}

List<FormBuilderFieldOption<String>> convertToFormBuilderFieldOption(
    Map<String, String>? optionsMap) {
  late List<FormBuilderFieldOption<String>> tempOptionsList = [];

  if (optionsMap != null) {
    optionsMap.forEach((key, value) {
      FormBuilderFieldOption<String> opetionobj = FormBuilderFieldOption(
        value: value,
        child: Text(key),
      );
      tempOptionsList.add(opetionobj);
    });
  }
  return tempOptionsList;
}

class NewField extends StatelessWidget {
  const NewField({
    super.key,
    required this.name,
    required this.fieldType,
    required this.label,
    required this.isRequired,
    required this.options,
  });
  final String name;
  final String fieldType;
  final String label;
  final bool isRequired;
  final Map<String, String>? options;

  InputDecoration inputDecorationCreator(String label, errorText) {
    return InputDecoration(
        labelText: label,
        // errorText: errorText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.red)));
  }

  Widget formFieldSelector() {
    print(fieldType);
    print(options);
    switch (fieldType) {
      case "calenderDate":
        return FormBuilderDateTimePicker(
          name: name,
          format: DateFormat('yyyy-MM-dd'),
          validator: FormBuilderValidators.required(),
          initialDatePickerMode: DatePickerMode.day,
          inputType: InputType.date,
          decoration:
              inputDecorationCreator(label, "Please entry valid ${label}"),
        );
      case "email":
        return FormBuilderTextField(
          name: 'email',
          keyboardType: TextInputType.emailAddress,
          decoration:
              inputDecorationCreator(label, "Please entry valid ${label}"),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        );
      case "text":
        return FormBuilderTextField(
          name: name,
          validator: FormBuilderValidators.required(),
          decoration:
              inputDecorationCreator(label, "Please entry valid ${label}"),
        );

      case "mobile-no":
        return FormBuilderTextField(
          name: name,
          validator: FormBuilderValidators.required(),
          keyboardType: TextInputType.phone,
          decoration:
              inputDecorationCreator(label, "Please entry valid ${label}"),
        );
      case "number":
        return FormBuilderTextField(
          name: name,
          validator: FormBuilderValidators.required(),
          keyboardType: TextInputType.number,
          decoration:
              inputDecorationCreator(label, "Please entry valid ${label}"),
        );

      case "textarea":
        return FormBuilderTextField(
          minLines: 3,
          maxLines: 7,
          name: name,
          validator: FormBuilderValidators.required(),
          decoration:
              inputDecorationCreator(label, "Please entry valid ${label}"),
        );
      case "radio":
        String? initvalue = options?[options!.keys.first];
        return FormBuilderRadioGroup<String>(
          decoration: inputDecorationCreator(label, ""),
          initialValue: initvalue,
          name: name,
          // onChanged: _onChanged,
          validator:
              FormBuilderValidators.compose([FormBuilderValidators.required()]),
          options: convertToFormBuilderFieldOption(options),

          controlAffinity: ControlAffinity.trailing,
        );
    }

    return FormBuilderTextField(
      name: name,
      validator: FormBuilderValidators.required(),
      decoration: inputDecorationCreator(label, "Please entry valid ${label}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8), child: formFieldSelector());
  }
}
