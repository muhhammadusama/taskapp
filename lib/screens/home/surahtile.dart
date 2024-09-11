import 'package:flutter/material.dart';
import 'package:personal_home_app/models/task.dart';
import 'package:personal_home_app/screens/home/settings_file.dart';

class SurahTile extends StatelessWidget {
  final Task task;
  //SurahTile({this.brew})
  const SurahTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    void showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
              child: const SettingsFile(),
            );
          });
    }

    taskCompletion() {
      if (task.isCompleted) {
        return const Text("Today's Task is Completed",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
      } else {
        return const Text("Today's Task is not Completed");
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
            tileColor: Colors.tealAccent,
            onTap: () {
              showSettingsPanel();
            },
            leading: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.black,
              child: Text(
                task.name,
                style: const TextStyle(color: Colors.tealAccent),
              ),
              //backgroundImage: const AssetImage('assets/coffee_icon.png'),
            ),
            title: Text(
              task.name,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: taskCompletion()),
      ),
    );
  }
}
