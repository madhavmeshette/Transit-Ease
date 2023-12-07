import 'package:flutter/material.dart';

class BookTicketScreen extends StatefulWidget {
  final String busNumber;
  final String source;
  final String destination;

  BookTicketScreen({
    required this.busNumber,
    required this.source,
    required this.destination,
  });

  @override
  _BookTicketScreenState createState() => _BookTicketScreenState();
}

class _BookTicketScreenState extends State<BookTicketScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Ticket'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bus Number: ${widget.busNumber}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Source: ${widget.source}',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Destination: ${widget.destination}',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: contactNumberController,
              decoration: InputDecoration(
                labelText: 'Enter your contact number',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.payment, color: Colors.deepPurpleAccent),
                SizedBox(width: 8.0),
                Text(
                  'Payment Options',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                _buildPaymentOption('UPI'),
                SizedBox(width: 8.0),
                _buildPaymentOption('Credit Card'),
                SizedBox(width: 8.0),
                _buildPaymentOption('Debit Card'),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Simulate payment logic (replace this with real payment integration)
                showPaymentConfirmationDialog();
              },
              child: Text('Pay and Book Now'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurpleAccent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String option) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurpleAccent),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        option,
        style: TextStyle(
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  void showPaymentConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Confirmation'),
          content: Text('Your ticket has been booked successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Pop the BookTicketScreen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
