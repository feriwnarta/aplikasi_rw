import 'package:aplikasi_rw/screen/login_screen/validate/validate_email_and_password.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationForm {
  // field stepper
  int currentStep = 0;
  // key form
  final _formKeyAccount = GlobalKey<FormState>();
  final _formKeyContact = GlobalKey<FormState>();
  // checker visibility password
  bool _isObscureFirst = true;
  bool _isObscureSecond = true;
  // date time
  DateTime date;

  // textfield form controller  account
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerFirstPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();

  // textfield form controller contact
  TextEditingController controllerBirthDay = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Stepper(
          physics: ScrollPhysics(),
          type: StepperType.horizontal,
          currentStep: currentStep,
          onStepTapped: (step) => setState(() => currentStep = step),
          controlsBuilder: (context, {onStepCancel, onStepContinue}) {
            return Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  child: Text('Next'),
                  onPressed: onStepContinue,
                )),
                SizedBox(width: 20),
                if (currentStep != 0)
                  Expanded(
                      child: ElevatedButton(
                    child: Text('Back'),
                    onPressed: onStepCancel,
                  )),
              ],
            );
          },
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;

            // checker validate step account
            if (currentStep == 0) {
              if (_formKeyAccount.currentState.validate()) {
                setState(() {
                  if (isLastStep) {
                    print('completed');
                  } else {
                    currentStep++;
                  }
                });
              }
            }
          },
          onStepCancel: () {
            currentStep > 0 ? setState(() => currentStep--) : currentStep = 0;
          },
          steps: getSteps()),
    );
  }

  List<Step> getSteps() {
    return [
      stepAccount(),
      stepContact(),
      Step(isActive: currentStep >= 2, title: Text('3'), content: Container()),
    ];
  }

  Step stepContact() {
    return Step(
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        title: Text('Contact'),
        content: Form(
          key: _formKeyContact,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person_outline_sharp),
                      hintText: 'Full name',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                child: TextFormField(
                  controller: controllerBirthDay,
                  keyboardType: TextInputType.datetime,
                  // initialValue: controllerBirthDay.text,
                  decoration: InputDecoration(
                      icon: Icon(Icons.date_range_outlined),
                      hintText: 'birthday',
                      border: UnderlineInputBorder()),
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    pickDate(context).then((_) => controllerBirthDay.text =
                        '${date.day}/${date.month}/${date.year}');
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                child: TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      icon: Icon(Icons.home_outlined),
                      hintText: 'Address',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                child: TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      icon: Icon(Icons.location_city_outlined),
                      hintText: 'city',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.contact_phone_outlined),
                      hintText: 'Phone',
                      border: UnderlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  Step stepAccount() {
    return Step(
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        title: Text('Account'),
        content: Form(
          key: _formKeyAccount,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) =>
                      !isValidEmail(email) ? 'Email not valid' : null,
                  decoration: InputDecoration(
                      icon: Icon(Icons.email_outlined),
                      hintText: 'Email',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerUsername,
                  keyboardType: TextInputType.name,
                  validator: (username) =>
                      (username.isEmpty) ? 'username cannot be empty' : (username.length <= 6) ? 'username must be more than 6' : null,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person_outline_sharp),
                      hintText: 'Username',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controllerFirstPassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isObscureFirst,
                      validator: (password) => (
                        !isValidPassword(password)
                          ? 'password not valid, Password must be more than 8 characters containing 1 uppercase letter, 1 lowercase letter, 1 number, and 1 unique characters, example (Myadmin1@, @MyAdm1n, my@dm1NN)'
                          : null),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key_outlined,
                          ),
                          errorMaxLines: 5,
                          suffixIcon: IconButton(
                            icon: Icon((_isObscureFirst)
                                ? Icons.visibility_off_outlined
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscureFirst = !_isObscureFirst;
                              });
                            },
                          ),
                          hintText: 'Password',
                          border: UnderlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isObscureSecond,
                      controller: controllerConfirmPassword,
                      validator: (password) =>
                          ((password == controllerFirstPassword.text)
                              ? null
                              : 'passwords are not the same'),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.keyboard_return_sharp,
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon((_isObscureSecond)
                                ? Icons.visibility_off_outlined
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscureSecond = !_isObscureSecond;
                              });
                            },
                          ),
                          hintText: 'Confirm Password',
                          border: UnderlineInputBorder()),
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 60),
        lastDate: DateTime(DateTime.now().year + 10));
    if (newDate == null) return;
    setState(() => date = newDate);
  }
}
