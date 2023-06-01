import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pictionary/components/loading.dart';
import 'package:pictionary/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pictionary/components/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Form state.
  String email = '';
  String password = '';
  String error = '';
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green[100],
            appBar: AppBar(
              backgroundColor: Colors.green[700],
              elevation: 1.5,
              title: Text('Register into Pictionary'),
              actions: [
                TextButton.icon(
                  onPressed: () => widget.toggleView(),
                  style: textButtonStyle,
                  icon: Icon(Icons.login),
                  label: Text('Sign in'),
                ),
              ],
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        CupertinoIcons.pencil_outline,
                        size: 86,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'email address',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !EmailValidator.validate(value)) {
                            return 'Please enter a valide email';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'password',
                        ),
                        validator: (value) {
                          if (value == null || value.length <= 6) {
                            return 'The password must be at least 6 characters';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic user =
                                await _authService.register(email, password);
                            // setState(() => loading = true);
                            if (user == null) {
                              setState(
                                  () => error = 'Invalid email or password');
                            }
                            // setState(() => loading = false);
                          }
                        },
                        style: elevatedButtonStyle,
                        child: Text('Register'),
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
