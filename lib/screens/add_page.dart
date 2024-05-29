import 'package:flutter/material.dart';
import 'package:todo_app/const/size.dart';
import 'package:todo_app/services/todo_services.dart';
import 'package:todo_app/utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key, this.todo});
  final Map? todo;

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 11, 2),
        title: Center(
          child: Text(
            isEdit ? 'Edit Todo' : 'Add Todo',
            style: const TextStyle(color: Colors.amber),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: screenHeight * 0.02),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 186, 141, 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                isEdit ? 'Update' : 'Submit',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // UPDATE DATA

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print('You can not call updated without todo data');
      return;
    }
    final id = todo['_id'];

    // 1. Get the data from form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    // 2. Submit updated data to the server
    final isSucess = await TodoServices.updateTodo(id, body);

    // 3. Show success or fail message based on status
    if (isSucess) {
      showSuccessMessage(context, message: 'Updation Success');
    } else {
      showErrorMessage(context, message: 'Updation Failed');
    }
  }

  // POST API

  Future<void> submitData() async {
    // 1. Get the data from form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    // 2. Submit data to the server
    final isSuccess = await TodoServices.submitTodo(body);

    // 3. Show success or fail message based on status
    if (isSuccess) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage(context, message: 'Creation Successful');
    } else {
      showErrorMessage(context, message: 'Creation Failed');
    }
  }
}
