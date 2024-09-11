import 'package:flutter/material.dart';
import 'package:personal_home_app/models/task.dart';
import 'package:personal_home_app/screens/home/load_from_pdf.dart';
import 'package:personal_home_app/screens/home/surahlist.dart';
import 'package:personal_home_app/screens/home/task_history_screen.dart';
import 'package:personal_home_app/services/auth.dart';
import 'package:personal_home_app/services/database.dart';
import 'package:personal_home_app/shared/constants.dart';
import 'package:provider/provider.dart';

class Surah extends StatefulWidget {
  const Surah({super.key});

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
      initialData: const [],
      value: DatabaseService().tasks,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              "Surah Yaseen",
              style: TextStyle(color: Colors.tealAccent),
            ),
            actions: [
              ElevatedButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  label: const Text("Signout"),
                  style: AppButtonStyles.elevatedButtonStyle),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TaskHistoryScreen()));
                },
                child: const Icon(
                  Icons.history,
                  color: Colors.tealAccent,
                ),
              )
            ],
            leading: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black)),
                onPressed: () {
                  Navigator.pop(context);
                },
                label: Icon(
                  Icons.arrow_back,
                  color: Colors.tealAccent,
                )),
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/startbackground.jpg"), // Add your image here
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Surahlist(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      // Navigate to the new page when clicked
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const //TextFromFile()),
                                  PDFScreen()
                              //HomePage()
                              ));
                    },
                    child: const Text(
                      'Click here To Read Surah Yaseen',
                      style: TextStyle(
                        color: Colors.tealAccent,
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
