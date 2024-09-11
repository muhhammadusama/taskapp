import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String name;
  bool isCompleted;
  Timestamp date;

  Task(
      {required this.name,
      this.isCompleted = false,
      required this.date,
      required lastResetDate});

  // factory Task.fromFirestore(DocumentSnapshot doc) {
  //   Map data = doc.data() as Map<String, dynamic>;
  //   return Task(
  //     id: doc.id,
  //     name: data['taskName'] ?? '',
  //     isCompleted: data['isCompleted'] ?? false,
  //     date: data['date'] ?? Timestamp.now(),
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'taskName': name,
  //     'isCompleted': isCompleted,
  //     'date': date,
  //   };
  // }
}
