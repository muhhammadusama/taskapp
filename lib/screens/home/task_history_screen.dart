import 'package:flutter/material.dart';
import 'package:personal_home_app/models/userdata.dart';
import 'package:personal_home_app/services/database.dart';

class TaskHistoryScreen extends StatefulWidget {
  const TaskHistoryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TaskHistoryScreenState createState() => _TaskHistoryScreenState();
}

class _TaskHistoryScreenState extends State<TaskHistoryScreen> {
  List<UserData> allUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchTaskHistories();
  }

  Future<void> _fetchTaskHistories() async {
    List<UserData> users = await DatabaseService().getAllUserTaskHistories();
    setState(() {
      allUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Task History of All Users'),
          leading: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back))),
      body: allUsers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allUsers.length,
              itemBuilder: (context, index) {
                UserData user = allUsers[index];
                return ExpansionTile(
                  title: Text(user.name),
                  subtitle: Text(
                      "Last task completion: ${user.isCompleted ? 'Yes' : 'No'}"),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Task History:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          for (String date in user.taskHistory.keys)
                            // Text(
                            //     '$date: ${user.taskHistory[date] ? 'Completed' : 'Not Completed'}'),
                            Text(
                              '$date: ${user.taskHistory[date] == true ? 'Completed' : 'Not Completed'}',
                            ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
