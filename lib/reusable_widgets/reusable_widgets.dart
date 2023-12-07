import 'package:flutter/material.dart';
import 'package:transit_ease/screens/book_ticket.dart';
import 'package:transit_ease/screens/newmap.dart';
import 'package:fl_chart/fl_chart.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 380,
    height: 800,
    color: Colors.white,
  );
}

TextField reusableTextField(String hint, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

class BusInfoContainer extends StatelessWidget {
  final String source;
  final String destination;
  final String busNumber;
  final int crowCounter;

  BusInfoContainer({
    required this.source,
    required this.destination,
    required this.busNumber,
    required this.crowCounter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_bus,
                color: Colors.blue,
                size: 24.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Bus Number: $busNumber',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  fontFamily: 'Poppins-Bold',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.green,
                size: 20.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Source: $source',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Poppins-Bold',
                ),
              ),
              SizedBox(width: 8.0), // Add spacing
              ProbabilityChart(crowCounter: crowCounter),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.red,
                size: 20.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Destination: $destination',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Poppins-Bold',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Crowd Counter:',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Poppins-Bold',
                ),
              ),
              Text(
                '$crowCounter',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Handle live tracking logic
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SSimepleMap()));
                },
                icon: Icon(Icons.location_on),
                label: Text('Live Track Bus'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(width: 8.0), // Add spacing between buttons
              ElevatedButton.icon(
                onPressed: () {
                  // Handle live tracking logic
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookTicketScreen(
                                busNumber: this.busNumber,
                                source: this.source,
                                destination: this.destination,
                              )));
                },
                icon: Icon(Icons.airplane_ticket_outlined),
                label: Text('Book Ticket'),
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
        ],
      ),
    );
  }
}

class ProbabilityChart extends StatelessWidget {
  final int crowCounter;

  ProbabilityChart({required this.crowCounter});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Seat Probability',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins-Bold',
          ),
        ),
        SizedBox(height: 30.0),
        Container(
          width: 30.0,
          height: 30.0,
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 10.0,
              sections: _generatePieChartSections(),
              borderData: FlBorderData(show: false),
              pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {}),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _generatePieChartSections() {
    int busCapacity = 60;
    int availableSeats = busCapacity - crowCounter;
    int occupiedSeats = crowCounter;

    return [
      PieChartSectionData(
        color: Colors.green,
        value: availableSeats.toDouble(),
        title: '${_calculatePercentage(availableSeats, busCapacity)}%',
        radius: 30.0,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: occupiedSeats.toDouble(),
        title: '${_calculatePercentage(occupiedSeats, busCapacity)}%',
        radius: 30.0,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      ),
    ];
  }

  int _calculatePercentage(int value, int total) {
    if (total == 0) {
      return 0;
    }
    return ((value / total) * 100).round();
  }
}
