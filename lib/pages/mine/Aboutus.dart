import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  final List<Map<String, String>> teamMembers = [
    {'Name': 'Hualong Qiao', 'Student ID': 'h3qiao'},
    {'Name': 'Yu Xia', 'Student ID': 'y27xia'},
    {'Name': 'Letian Zhang', 'Student ID': 'l536zhan'},
    {'Name': 'Ziniu Yu', 'Student ID': 'z39yu'},
    {'Name': 'Guangwei Tang', 'Student ID': 'g24tang'},
    {'Name': 'Yue Wang', 'Student ID': 'y595wang'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Uwaterloo Exchange",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Team members",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(),
                1: FixedColumnWidth(120),
              },
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Name',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Student ID',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ]),
                ...teamMembers.map((member) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(member['Name'] ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(member['Student ID'] ?? ''),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
