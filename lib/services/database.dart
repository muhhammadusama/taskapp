import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_home_app/models/task.dart';
import 'package:personal_home_app/models/userdata.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // ignore: prefer_typing_uninitialized_variables
  final uid;
  DatabaseService({this.uid});

//CollectionReference
  final CollectionReference surahCollection =
      FirebaseFirestore.instance.collection('task');

//update user data
  // Future updateUserData(String name, bool isCompleted, DateTime date,
  //     DateTime lastResetDate) async {
  //   return await surahCollection.doc(uid).set({
  //     'name': name,
  //     'isCompleted': isCompleted,
  //     'date': date,
  //     'lastResetDate': lastResetDate
  //   });
  // }
  Future updateUserData(String name, bool isCompleted, DateTime date,
      DateTime lastResetDate) async {
    String today = DateTime.now()
        .toIso8601String()
        .split('T')
        .first; // Store only the date part

    return await surahCollection.doc(uid).set(
        {
          'name': name,
          'isCompleted': isCompleted,
          'date': date,
          'lastResetDate': lastResetDate,
          'taskHistory': {
            today: isCompleted,
          },
        },
        SetOptions(
            merge:
                true)); // Merge allows you to update without overwriting the existing data
  }

//UserData Stream
  // UserData _userDataFromStream(DocumentSnapshot snapshot) {
  //   return UserData(
  //       uid: uid,
  //       name: snapshot['name'],
  //       isCompleted: snapshot['isCompleted'],
  //       date: snapshot['date']);
  // }

  // UserData _userDataFromStream(DocumentSnapshot snapshot) {
  //   var data = snapshot.data() as Map<String, dynamic>?;

  //   if (data == null) {
  //     //print("No data found for document");
  //     throw Exception("No data found");
  //   }

  //   // Properly convert Firestore's Timestamp to DateTime
  //   return UserData(
  //       uid: uid,
  //       name: data['name'] ?? 'Unknown',
  //       isCompleted: data['isCompleted'] ?? false,
  //       date: (data['date'] as Timestamp).toDate(), // Conversion here
  //       lastResetDate: (data['date'] as Timestamp).toDate());
  // }

  UserData _userDataFromStream(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception("No data found");
    }

    // Ensure taskHistory is properly handled
    Map<String, bool> taskHistory = {};
    if (data['taskHistory'] != null) {
      taskHistory = Map<String, bool>.from(data['taskHistory']);
    }

    return UserData(
      uid: uid,
      name: data['name'] ?? 'Unknown',
      isCompleted: data['isCompleted'] ?? false,
      date: (data['date'] as Timestamp).toDate(),
      lastResetDate:
          (data['lastResetDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      taskHistory: taskHistory, // Assign taskHistory to UserData
    );
  }

//get user data stream

  //task list from snapshot
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Task(
        name: doc.get('name') ?? '',
        isCompleted: doc.get('isCompleted') ?? false,
        date: doc.get('date') ?? DateTime.now(),
        lastResetDate: doc.get('lastResetDate') ?? DateTime(2000, 1, 1),
      );
    }).toList();
  }

  //get stream of tasks
  Stream<List<Task>> get tasks {
    return surahCollection.snapshots().map(_taskListFromSnapshot);
  }

  // Stream<UserData> get userData {
  //   //print(userData);
  //   return surahCollection.doc(uid).snapshots().map(_userDataFromStream);
  // }

  Stream<UserData> get userData {
    //print("Fetching data for user with UID: $uid");

    return surahCollection.doc(uid).snapshots().map((snapshot) {
      // Print raw snapshot data
      //print("Snapshot data: ${snapshot.data()}");

      if (!snapshot.exists) {
        //print("Document does not exist for UID: $uid");
        return UserData(
            uid: uid,
            name: 'Unknown',
            isCompleted: false,
            date: DateTime.now(),
            lastResetDate: DateTime(2000, 1, 1),
            taskHistory: {});
      }

      return _userDataFromStream(snapshot);
    });
  }

  // Future<void> resetDailyTask() async {
  //   // Logic to reset data, e.g., updating Firestore
  //   // Fetch all users from Firestore
  //   try {
  //     QuerySnapshot querySnapshot = await surahCollection.get();
  //     // Loop through all users and check if their tasks need to be reset
  //     for (var doc in querySnapshot.docs) {
  //       final data = doc.data() as Map<String, dynamic>?;

  //       if (data != null) {
  //         // Update Firestore: reset 'isCompleted' and set 'lastResetDate' to today for the user
  //         await surahCollection.doc(doc.id).update({
  //           'isCompleted': false, // Reset task completion
  //         });
  //         //print('Task reset for user: ${doc.id}');
  //       }
  //     }
  //     //print("Daily task reset executed at: ${DateTime.now()}");
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print(e.toString());
  //   }
  // }
  Future<void> resetDailyTask() async {
    print("Reset Daily Task Function is invoked");
    String today = DateTime.now().toIso8601String().split('T').first;

    try {
      print("Reset try block is sstarted");
      QuerySnapshot querySnapshot = await surahCollection.get();

      print("Data is getted");

      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          print("data is not null");
          Map<String, dynamic> taskHistory = data['taskHistory'] ?? {};
          taskHistory[today] =
              data['isCompleted']; // Record the status before resetting

          await surahCollection.doc(doc.id).update({
            'isCompleted': false, // Reset task completion
            'taskHistory':
                taskHistory, // Update history with the task status for today
          });
          print("Daily task reset executed at: ${DateTime.now()}");
        } else {
          print("data is null");
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  // Fetch task history for all users
  Future<List<UserData>> getAllUserTaskHistories() async {
    List<UserData> allUsers = [];

    try {
      QuerySnapshot querySnapshot = await surahCollection.get();

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          // Ensure taskHistory is properly handled
          Map<String, bool> taskHistory = {};
          if (data['taskHistory'] != null) {
            taskHistory = Map<String, bool>.from(data['taskHistory']);
          }

          // Add each user’s data to the list
          allUsers.add(UserData(
            uid: doc.id, // Use document ID as user UID
            name: data['name'] ?? 'Unknown',
            isCompleted: data['isCompleted'] ?? false,
            date: (data['date'] as Timestamp).toDate(),
            lastResetDate: (data['lastResetDate'] as Timestamp?)?.toDate() ??
                DateTime.now(),
            taskHistory: taskHistory,
          ));
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching task histories: $e');
    }

    return allUsers;
  }
}
