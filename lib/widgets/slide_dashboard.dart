import 'package:flutter/material.dart';

class SlideDashboard extends StatelessWidget {
  final String text;
  final Icon icon;
  final Color? background;
  final Color? textColor;
  final String url;
  const SlideDashboard({
    super.key, 
    required this.icon,
    required this.text,
    required this.background,
    required this.textColor,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.of(context).pushReplacementNamed(url);
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Card(
            color: background,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 24, color: textColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                IconButton(
                  icon: icon,
                  onPressed: () {
                    // Handle edit action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
}
}
