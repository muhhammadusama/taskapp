import 'package:flutter/material.dart';
import 'package:personal_home_app/services/auth.dart';
import 'package:personal_home_app/shared/constants.dart';
import 'package:personal_home_app/shared/loading.dart';

class Register extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final toggleView;
  const Register({super.key, required this.toggleView});

  //Register({required this.toggleView});
  //const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String name = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Loading();
    } else {
      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.tealAccent, // Change this to the color you want
              ),
              backgroundColor: Colors.black,
              elevation: 0.0,
              title: const Text(
                "Register Yourself ",
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
                      "Signin",
                      style: TextStyle(color: Colors.tealAccent, fontSize: 20),
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
                    height: 20,
                  ),
                  const Text("Enter Your Name Here"),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Name"),
                    validator: (val) =>
                        val!.isEmpty ? 'Enter a your name please' : null,
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Enter Your Email Here"),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                    validator: (val) =>
                        val!.isEmpty ? 'Enter a valid email' : null,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Enter Your Password Here"),
                  const SizedBox(
                    height: 8,
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
                        dynamic result = await _auth.registerWithEmail(
                            name, email, password);
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
                    child: const Text("Sign Up",
                        style: TextStyle(color: Colors.tealAccent)),
                  ),
                  const SizedBox(
                    height: 8,
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
}
