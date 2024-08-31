import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              icon,
              size: 25,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
