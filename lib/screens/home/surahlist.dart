import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_home_app/models/task.dart';
import 'package:personal_home_app/screens/home/surahtile.dart';
import 'package:provider/provider.dart';

class Surahlist extends StatefulWidget {
  const Surahlist({super.key});

  @override
  State<Surahlist> createState() => _SurahlistState();
}

class _SurahlistState extends State<Surahlist> {
  List doct = [];
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final tasks = Provider.of<List<Task>>(context);

    // brews.forEach((brew) {
    //   print(brew.name);
    //   print(brew.sugars);
    //   print(brew.strength);
    // });

    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return SurahTile(task: tasks[index]);
        });
  }
}
