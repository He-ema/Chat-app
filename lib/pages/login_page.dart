import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Image.asset('assets/images/scholar.png'),
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Row(
                    children: [
                      Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: 'Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    obscureText: true,
                    hintText: 'Password',
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: 'Login',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          Navigator.pushNamed(context, ChatPage.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                                context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context,
                                'Wrong password provided for that user.');
                          }
                        } catch (e) {
                          showSnackBar(context, 'There is an Error');
                        }
                        isLoading = false;
                        setState(() {});
                      } else {}
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ? ',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        child: Text(
                          'Register now  ',
                          style: TextStyle(color: Color(0xffC7EDE6)),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
