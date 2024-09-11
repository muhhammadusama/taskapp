import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_home_app/models/userdata.dart';
import 'package:personal_home_app/services/database.dart';
import 'package:personal_home_app/shared/constants.dart';
import 'package:personal_home_app/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsFile extends StatefulWidget {
  const SettingsFile({super.key});

  @override
  State<SettingsFile> createState() => _SettingsFileState();
}

class _SettingsFileState extends State<SettingsFile> {
  final _formkey = GlobalKey<FormState>();
  bool currentisCompleted = false;
  String currentName = '';
  String currentisCompleteds = 'no';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Loading();
          //}

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            //DateTime _currentDate = DateTime.now();

            return Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      "Update Your Task Status for ${userData?.name}",
                      style: const TextStyle(fontSize: 25.0),
                    ),

                    const SizedBox(
                      height: 28.0,
                    ),
                    const Text(
                      'کیا آپ نے آج سورۃ یسین پڑھی؟', // Urdu text
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily:
                            'Jameel Noori Nastaleeq', // The font family you defined
                      ),
                    ),
                    //Text("کیا آپ نے آج سورۃ یسین پڑھی؟"),
                    // const SizedBox(
                    //   height: 28.0,
                    // ),
                    // const Text(
                    //   "Have you completed the task?",
                    //   style: TextStyle(fontSize: 18.0),
                    // ),
                    const SizedBox(
                      height: 28.0,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: textInputDecoration.copyWith(
                          hintText: "Task Status?"),

                      // Check if `currentisCompleted` is null, then set the default
                      //value: currentisCompleteds == 'no' ? "yes" : "no",

                      items: const [
                        DropdownMenuItem(value: "yes", child: Text("Yes")),
                        DropdownMenuItem(value: "no", child: Text("No")),
                      ],

                      onChanged: (String? val) {
                        //print(val);
                        if (val == "yes") {
                          setState(() {
                            currentisCompleted = true;
                          });
                        } else {
                          setState(() {
                            currentisCompleted = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 28.0,
                    ),
                    ElevatedButton(
                      style: AppButtonStyles.elevatedButtonStyle.copyWith(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.black)),
                      // style: ButtonStyle(
                      //     backgroundColor:
                      //         WidgetStateProperty.all<Color>(Colors.pink)),
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await DatabaseService(uid: user?.uid).updateUserData(
                              currentName == '' ? userData!.name : currentName,
                              currentisCompleted,
                              userData!.date,
                              userData.date
                              // _currentSugars == '0'
                              //     ? userData!.sugars
                              //     : _currentSugars,
                              // _currentStrength == 0
                              //     ? userData!.strength
                              //     : _currentStrength);
                              );
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          //print(currentisCompleted);
                        }
                      },
                    )
                  ],
                ));
          } else {
            return const Loading();
          }
        });
  }
}
