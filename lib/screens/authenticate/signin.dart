import 'package:flutter/material.dart';
import 'package:personal_home_app/services/auth.dart';
import 'package:personal_home_app/shared/constants.dart';
import 'package:personal_home_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final toggleView;

  const SignIn({super.key, required this.toggleView});

  //const SignIn({super.key});
  //SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.tealAccent, // Change this to the color you want
                ),
                backgroundColor: Colors.black,
                elevation: 0.0,
                title: const Text(
                  "Sign in To The Home App ",
                  style: TextStyle(color: Colors.tealAccent),
                ),
                actions: [
                  TextButton.icon(
                      onPressed: () {
                        widget.toggleView();
                      },
                      icon: const Icon(
                        Icons.person,
                        color: Colors.tealAccent,
                      ),
                      label: const Text(
                        "Register",
                        style:
                            TextStyle(color: Colors.tealAccent, fontSize: 20),
                      ))
                ]),
            body: Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/startbackground.jpg"), // Add your image here
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text("Enter Your Email Here"),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Email"),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a valid email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text("Enter Your Password Here"),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Password"),
                      validator: (val) => val!.length < 6
                          ? 'Password shoud be atleast 6 letters long'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.signInWithEmail(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'email or password is incorrect';
                            });
                          }
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.pink)),
                      child: const Text("Sign In",
                          style: TextStyle(color: Colors.tealAccent)),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      error,
                      style: const TextStyle(
                          color: Colors.red, fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
            ]));
  }
}
