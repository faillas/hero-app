import 'package:flutter/material.dart';
import 'package:hero/palette.dart';

class Section extends StatelessWidget {
  final String title;
  final List<Widget> items;
  final bool? report;
  final VoidCallback onDownload;

  const Section({super.key, 
    required this.title,
    required this.items,
    required this.onDownload,
    required this.report
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: (report == true)
              ?ElevatedButton.icon(
                onPressed: onDownload,
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                label: const Text("Report", style: TextStyle(color: Palette.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0), // Small border radius
                  ),
                ),
              )
              :Container(),
          ),
          const Divider(height: 1, color: Colors.grey),
          ...items,
        ],
      ),
    );
  }
}