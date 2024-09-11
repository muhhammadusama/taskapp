// class UserData {
//   final String uid;
//   final String name;
//   final bool isCompleted;
//   final DateTime date;
//   final DateTime lastResetDate;
//   UserData(
//       {required this.uid,
//       required this.name,
//       required this.isCompleted,
//       required this.date,
//       required this.lastResetDate});
// }
class UserData {
  final String uid;
  final String name;
  final bool isCompleted;
  final DateTime date;
  final DateTime lastResetDate;
  final Map<String, bool> taskHistory; // New field to track daily completion

  UserData({
    required this.uid,
    required this.name,
    required this.isCompleted,
    required this.date,
    required this.lastResetDate,
    required this.taskHistory, // Initialize taskHistory in the constructor
  });
}
