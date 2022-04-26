import 'package:aplikasi_rw/screen/login_screen/validate/validate_email_and_password.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final _formKeyIdentity = GlobalKey<FormState>();

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
  TextEditingController controllerFullName = TextEditingController();
  TextEditingController controllerAdress = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  // textfield form controller identity
  TextEditingController controllerNoKtp = TextEditingController();
  TextEditingController controllerNoKK = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Stepper( 

          physics: ScrollPhysics(),
          type: StepperType.horizontal,
          currentStep: currentStep,
          // onStepTapped: (step) => setState(() {
          //       if (_formKeyAccount.currentState.validate() && step == 0) {
          //         currentStep = step;
          //       } else if (_formKeyContact.currentState.validate() &&
          //           step == 1) {
          //         currentStep = step;
          //       }
          //     }),
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
            } else if (currentStep == 1) {
              if (_formKeyContact.currentState.validate()) {
                setState(() {
                  if (isLastStep) {
                    print('completed');
                  } else {
                    currentStep++;
                  }
                });
              }
            } else if (currentStep == 2) {
              if (_formKeyIdentity.currentState.validate()) {
                setState(() {
                  if (isLastStep) {
                    // cek nik dan ktp
                    // kemudian kehalaman akhir
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
    return [stepAccount(), stepContact(), stepIdentity()];
  }

  Step stepCompleted() {
    return Step(
        isActive: currentStep >= 2,
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        title: Text('Identity'),
        content: Form(
          key: _formKeyIdentity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerNoKtp,
                  keyboardType: TextInputType.number,
                  validator: (ktp) =>
                      (ktp.isEmpty) ? 'No Ktp can\t be empty' : null,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.idCard),
                      hintText: 'No Ktp',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerNoKK,
                  keyboardType: TextInputType.number,
                  validator: (username) =>
                      (username.isEmpty) ? 'No KK can\'t be empty' : null,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.fileAlt),
                      hintText: 'No KK',
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

  Step stepIdentity() {
    return Step(
        isActive: currentStep >= 2,
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        title: Text('Identity'),
        content: Form(
          key: _formKeyIdentity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerNoKtp,
                  keyboardType: TextInputType.number,
                  validator: (ktp) =>
                      (ktp.isEmpty) ? 'No Ktp can\t be empty' : null,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.idCard),
                      hintText: 'No Ktp',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerNoKK,
                  keyboardType: TextInputType.number,
                  validator: (username) =>
                      (username.isEmpty) ? 'No KK can\'t be empty' : null,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.fileAlt),
                      hintText: 'No KK',
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
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerFullName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person_outline_sharp),
                      hintText: 'Full name',
                      border: UnderlineInputBorder()),
                  validator: (name) =>
                      (name.isEmpty) ? 'full name can\'t be empty' : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
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
                  validator: (date) =>
                      (date.isEmpty) ? 'date can\'t be empty' : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerAdress,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      icon: Icon(Icons.home_outlined),
                      hintText: 'Address',
                      border: UnderlineInputBorder()),
                  validator: (address) =>
                      (address.isEmpty) ? 'address can\'t be empty' : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerCity,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      icon: Icon(Icons.location_city_outlined),
                      hintText: 'city',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerPhone,
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
                  validator: (username) => (username.isEmpty)
                      ? 'username cannot be empty'
                      : (username.length <= 6)
                          ? 'username must be more than 6'
                          : null,
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
                      validator: (password) => (!isValidPassword(password)
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
