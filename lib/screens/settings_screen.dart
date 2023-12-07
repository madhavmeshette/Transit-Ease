import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildSettingsItem('Option 1', 'Description for Option 1'),
            _buildSettingsItem('Option 2', 'Description for Option 2'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logic for the button action
                // For example, save settings or perform some action
                Navigator.pop(context); // Close the settings screen
              },
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 5),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            color: Colors.grey,
          ),
        ),
        Divider(),
      ],
    );
  }
}
