import 'package:flutter/material.dart';

class YourWidget extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  YourWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App'),
      ),
      body: const YourBodyWidget(),
    );
  }
}

class YourBodyWidget extends StatelessWidget {
  const YourBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showAccountCreatedNotification(context);
        },
        child: const Text('Show Notification'),
      ),
    );
  }
}

void showAccountCreatedNotification(BuildContext context) {
  final overlay = OverlayEntry(
    builder: (context) => Positioned(
      top: 0,
      left: 0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          color: Colors.green, // Customize the color as needed
          child: const Text(
            'Account created successfully!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlay);

  Future.delayed(const Duration(seconds: 2), () {
    overlay.remove();
  });
}
