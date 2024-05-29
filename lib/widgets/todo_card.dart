import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.index, required this.item, required this.navigateEdit, required this.deletedById});
  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(String) deletedById;

  @override
  Widget build(BuildContext context) {
   final id = item['_id'] as String;

    return Card(
      color: Colors.amber,
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            child: Text('${index + 1}')),
        title: Text(
          item['title'],
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          item['description'],
          style: TextStyle(color: Colors.black),
        ),
        trailing: PopupMenuButton(
            iconColor: Colors.black,
            onSelected: (value) {
              if (value == 'Edit') {
                navigateEdit(item);
              } else if (value == 'Delete') {
                deletedById(id);
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'Edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'Delete',
                  child: Text('Delete'),
                ),
              ];
            }),
      ),
    );
  }
}
