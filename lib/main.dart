import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal_home_app/firebase_options.dart';
import 'package:personal_home_app/screens/home/home.dart';
//import 'package:personal_home_app/screens/home/home_page.dart';
import 'package:personal_home_app/services/auth.dart';
import 'package:personal_home_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Callback dispatcher is about to be called");
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    print("Callback dispatcher is called");
  } catch (e) {
    // ignore: avoid_print
    print('$e');
  }

  // await Workmanager()
  //     .initialize(callbackDispatcher, // The top-level function that gets called
  //         isInDebugMode: true);
  //scheduleTaskForTesting();
  // Register the task to run daily
  scheduleTaskAtFixedTime(
      hour: 15, minute: 0); // Example: schedule task at 8:00 AM daily

  runApp(const MyApp());
}

void callbackDispatcher() {
  print("WorkManager task is about to run");

  Workmanager().executeTask((task, inputData) async {
    try {
      print("Initializing Firebase...");
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print("Firebase initialized successfully");

      // Check if the user is authenticated
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print(
            "No user is currently signed in. Firestore update cannot proceed.");
        return Future.value(false);
      }

      // Now call the reset function
      print("Calling resetDailyTask");
      await DatabaseService().resetDailyTask();
      print("Task reset successfully");
    } catch (e) {
      print("Error occurred during Firebase or Firestore operation: $e");
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

//Function to schedule the task at a specific time
void scheduleTaskAtFixedTime({required int hour, required int minute}) {
  DateTime now = DateTime.now();
  DateTime scheduledTime = DateTime(now.year, now.month, now.day, hour, minute);

  // If the current time is past today's scheduled time, schedule for tomorrow
  if (now.isAfter(scheduledTime)) {
    scheduledTime = scheduledTime.add(Duration(days: 1));
  }

  Duration initialDelay = scheduledTime.difference(now);

  // Schedule a one-off task to run at the specified time
  Workmanager().registerOneOffTask(
    "taskID-${DateTime.now().millisecondsSinceEpoch}", // Unique task identifier to avoid overwrites
    "updateTaskStatus",
    initialDelay:
        initialDelay, // Delay until the task runs at the scheduled time
    constraints: Constraints(
      networkType:
          NetworkType.connected, // Optional: Ensure task runs with network
    ),
  );
}

void scheduleTaskForTesting() {
  // Schedule a task to run 30 seconds from now
  Duration testDelay = Duration(seconds: 30);

  Workmanager().registerOneOffTask(
    "taskID-${DateTime.now().millisecondsSinceEpoch}", // Unique task identifier
    "updateTaskStatus",
    initialDelay: testDelay, // Delay for 30 seconds to test immediately
    constraints: Constraints(
      networkType:
          NetworkType.connected, // Optional: ensure task runs with network
    ),
  );

  print("Task scheduled to run in 30 seconds");
}
