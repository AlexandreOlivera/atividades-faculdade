import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: TodoHomePage(),
      
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<Map<String, dynamic>> tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask(String taskName) {
    if (taskName.isNotEmpty) {
      setState(() {
        tasks.insert(0, {'name': taskName, 'completed': false});
        taskController.clear();
      });
    }
  }

  void updateTaskPosition(int index, bool completed) {
    setState(() {
      var task = tasks.removeAt(index);
      task['completed'] = completed;
      completed ? tasks.add(task) : tasks.insert(0, task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Nova Tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () => addTask(taskController.text),
              child: Text('Cadastrar Tarefa'),              
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(tasks[index]['name']),
                    value: tasks[index]['completed'],
                    onChanged: (bool? value) {
                      updateTaskPosition(index, value!);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
