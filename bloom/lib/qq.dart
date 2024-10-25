import 'package:bloom/ad.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';



class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> with SingleTickerProviderStateMixin {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  String _currentWeatherCondition = '';
  String _currentWeatherImage = '';
  String _message = '';
  bool _isTapped = false;

  final List<Map<String, String>> weatherConditions = [
    {
      'condition': 'Sunny',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/sun.png',
    },
    {
      'condition': 'Rainy',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/rain.png',
    },
    {
      'condition': 'Cloudy',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/cloud.png',
    },
    {
      'condition': 'Cold',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/snow.png',
    },
    
    // Add more weather conditions as needed
  ];

  void _showWeatherDetails(Map<String, String> weather) {
    setState(() {
      _currentWeatherCondition = weather['condition']!;
      _currentWeatherImage = weather['imageUrl']!; // Set the image URL
      _message = 'Awesome!'; // Message when tapped
      _isTapped = true; // Set tapped state to true

      // Start confetti animation when a weather condition is tapped
      _confettiController.play();
    });

    // Reset after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTapped = false; // Reset tapped state
        _currentWeatherCondition = '';
        _currentWeatherImage = ''; // Clear image after delay
        _message = ''; // Clear message after delay
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 169, 249, 172),
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Color.fromARGB(255, 248, 101, 199),
          ),
        ),
        title: Text(
          "Weather Game",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
        ),
      ),
      body: Column(
        children: [
          // Message displayed at the bottom
          if (_message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                _message,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: weatherConditions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showWeatherDetails(weatherConditions[index]);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                      color: _isTapped ? Colors.orange[50] : Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Display the weather condition name
                        Text(
                          weatherConditions[index]['condition']!,
                          style: TextStyle(fontSize: 24),
                        ),
                        // Show the image only if it's the tapped condition
                        if (_currentWeatherCondition == weatherConditions[index]['condition'])
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Image.network(_currentWeatherImage, height: 60),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // "Let's Go" button
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: InkWell(
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>ClothingPage())); // Implement action for "Let's Go" button
              },
              child: Container(
                width: 300,
                height: 45,
                child: Center(
                  child: Text(
                    "Let's Go",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 69, 188),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 7, 87, 24).withOpacity(0.2),
                      offset: Offset(6, 7),
                      blurRadius: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Confetti Widget for the animation
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: 3.14, // radial value - π
            emissionFrequency: 0.05,
            numberOfParticles: 10,
            shouldLoop: false,
            colors: [Colors.blue, Colors.yellow, Colors.red],
          ),
        ],
      ),
    );
  }
}
