import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String selectedFeedbackType = 'General Feedback';
  TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provide Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Feedback Type:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            _buildFeedbackTypeDropdown(),
            SizedBox(height: 20),
            Text(
              'Tell us more:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            _buildFeedbackTextField(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logic to handle feedback submission
                // For example, you can print the feedback to the console
                Navigator.pop(context, 'Feedback submitted!');
              },
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackTypeDropdown() {
    return DropdownButton<String>(
      value: selectedFeedbackType,
      onChanged: (String? newValue) {
        setState(() {
          selectedFeedbackType = newValue!;
        });
      },
      items: <String>[
        'General Feedback',
        'Bug Report',
        'Feature Request',
        'Other',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildFeedbackTextField() {
    return TextField(
      controller: feedbackController,
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your feedback here...',
      ),
    );
  }
}
