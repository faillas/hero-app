import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String detail;
  final VoidCallback onRemove;

  const ListItem({super.key, 
    required this.icon,
    required this.text,
    required this.detail,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      subtitle: Text(detail),
      // trailing: IconButton(
      //   icon: const Icon(Icons.close),
      //   onPressed: onRemove,
      // ),
    );
  }
}