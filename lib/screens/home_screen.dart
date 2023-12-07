import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transit_ease/reusable_widgets/reusable_widgets.dart';
import 'package:transit_ease/screens/chat.dart';
import 'package:transit_ease/screens/feedback_screen.dart';
import 'package:transit_ease/screens/map.dart';
import 'package:transit_ease/screens/settings_screen.dart';
import 'package:transit_ease/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController fromController;
  late TextEditingController toController;

  @override
  void initState() {
    super.initState();
    fromController = TextEditingController();
    toController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Home Screen",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                width: 80), // Add some space between the title and coin symbol
            buildCoinSymbol(),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => handleLogout(),
          ),
        ],
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildSearchBox("From", fromController),
              const SizedBox(height: 16),
              buildSearchBox("To", toController),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Handle search bus logic
                },
                child: const Text("Search Bus"),
              ),
              SizedBox(
                height: 400, // Set the desired height for the map
                child: SimpleMap(),
              ),
              BusInfoContainer(
                source: 'Wagholi',
                destination: 'Pune station',
                busNumber: '48',
                crowCounter: 25,
              ),
              const SizedBox(
                height: 20,
              ),
              BusInfoContainer(
                source: 'Shivaji nagar',
                destination: 'Viman nagar',
                busNumber: '69',
                crowCounter: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              BusInfoContainer(
                source: 'Wagholi',
                destination: 'Katraj',
                busNumber: '96',
                crowCounter: 40,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: buildNavigateButton(),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildDrawerHeader(),
          buildDrawerItem(
            icon: Icons.add_location_alt_outlined,
            text: 'Nearby Bus Stops',
            onTap: () => handleNearby(context),
          ),
          buildDrawerItem(
            icon: Icons.directions_bus,
            text: 'Search Buses',
            onTap: () => handleSearch(context),
          ),
          buildDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () => handleProfileSettings(context),
          ),
          buildDrawerItem(
            icon: Icons.feedback,
            text: 'Feedback',
            onTap: () => handleFeedback(context),
          ),
          buildDrawerItem(
            icon: Icons.newspaper,
            text: 'News',
            onTap: () => handleNews(context),
          ),
          buildDrawerItem(
            icon: Icons.help,
            text: 'Help/Support',
            onTap: () => handleHelp(context),
          ),
          buildDrawerItem(
            icon: Icons.power_settings_new_outlined,
            text: 'Logout',
            onTap: () => handleLogout(),
          ),
        ],
      ),
    );
  }

  UserAccountsDrawerHeader buildDrawerHeader() {
    return const UserAccountsDrawerHeader(
      accountName: Text(
        'User Name',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600, // SemiBold
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      accountEmail: Text(
        'user@example.com',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500, // Medium
          fontSize: 16.0,
          color: Colors.white,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
          'https://images.getpng.net/uploads/preview/instagram-social-network-app-interface-icons-smartphone-frame-screen-template27-1151637511568djfdvfkdob.webp',
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
      ),
    );
  }

  Widget buildNavigateButton() => FloatingActionButton.extended(
      icon: const Icon(Icons.chat),
      label: const Text('ChatBot-AI'),
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: () {
        print('pressed');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage()),
        );
      });

  Widget buildDrawerItem(
      {required IconData icon, required String text, required Function onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24.0,
        color: Colors.blue, // You can customize the icon color
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      onTap: () => onTap(),
    );
  }

  void handleProfileSettings(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  void handleFeedback(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackScreen()),
    );
  }

  void handleHelp(BuildContext context) {
    Navigator.pop(context);
    // Add your feedback logic here
  }

  void handleNearby(BuildContext context) {
    Navigator.pop(context);
    // Add your feedback logic here
  }

  void handleNews(BuildContext context) {
    Navigator.pop(context);
    // Add your feedback logic here
  }

  void handleSearch(BuildContext context) {
    Navigator.pop(context);
    // Add your feedback logic here
  }

  void handleLogout() {
    FirebaseAuth.instance.signOut().then((value) {
      print("Signed Out");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    });
  }

  Widget buildSearchBox(String hintText, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          icon: const Icon(Icons.location_on),
        ),
      ),
    );
  }
}

Widget buildDrawerHeader() {
  return const DrawerHeader(
    decoration: BoxDecoration(
      color: Colors.blue,
    ),
    child: Text(
      'Your App Name',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// Add this function to create the coin symbol
Widget buildCoinSymbol() {
  return Container(
    padding: const EdgeInsets.all(8), // Adjust padding as needed
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 226, 212, 55),
      borderRadius: BorderRadius.circular(4), // Adjust border radius as needed
    ),
    child: const Row(
      children: [
        Icon(
          Icons.token_outlined, // You can change this to any money-related icon
          color: Colors.black, // Set icon color to black
          size: 20,
        ),
        SizedBox(width: 2), // Add some space between the icon and the value
        Text(
          '100',
          style: TextStyle(
            color: Colors.black, // Set text color to black
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
