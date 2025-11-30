import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class dashbord extends StatefulWidget {
  @override
  State<dashbord> createState() => _dashbordState();
}

class _dashbordState extends State<dashbord> {
  TextEditingController control1 = TextEditingController();
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = jsonEncode(tasks);
    await prefs.setString('tasks', data);
  }

  loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('tasks');
    if (data != null) {
      tasks = List<String>.from(jsonDecode(data));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 140, 255),
        toolbarHeight: 70,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TaskGo Dashboard",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Container(height: 2),

                Text(
                  "⌛Let’s Organize Your Day..🖋️",

                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            Text("📚", style: TextStyle(fontSize: 26, color: Colors.white)),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(""), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_right),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: control1,
                        decoration: InputDecoration(
                          hintText: "Enter task",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.white.withOpacity(0.9),
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {
                        if (control1.text.trim().isNotEmpty) {
                          tasks.add(control1.text.trim());
                          control1.clear();
                          saveTasks();
                          setState(() {});
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 140, 255),
                        minimumSize: Size(45, 45),
                      ),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                child: Image.asset("assets/images/ddl2.gif"),
              ),
              Container(
                height: 5,
                color: const Color.fromARGB(255, 255, 255, 255),
                margin: EdgeInsets.only(top: 5, left: 90, right: 90),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 45,
                            child: ClipOval(child: Icon(Icons.pending_actions)),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              height: 42,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 140, 255),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  tasks[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.done_outline_rounded,
                              color: const Color.fromARGB(255, 0, 140, 255),
                            ),
                            onPressed: () {
                              tasks.removeAt(index);
                              saveTasks();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
