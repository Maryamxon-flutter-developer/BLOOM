import 'package:bloom/qq.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';


class VegetablesPage extends StatefulWidget {
  const VegetablesPage({super.key});

  @override
  State<VegetablesPage> createState() => _VegetablesPageState();
}

class _VegetablesPageState extends State<VegetablesPage> with SingleTickerProviderStateMixin {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  String _currentVegetableName = '';
  String _currentVegetableImage = '';
  String _message = '';
  bool _isTapped = false;

  final List<Map<String, String>> vegetables = [
    {
      'name': 'Carrot',
      'imageUrl': 'https://www.shutterstock.com/image-vector/carrot-icon-600nw-571715974.jpg',
    },
    {
      'name': 'Broccoli',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6Nebrco4slBGXLMl6JcRAUOqN6Pg0Uf4sHw&s',
    },
    {
      'name': 'Cucumber',
      'imageUrl': 'https://t4.ftcdn.net/jpg/01/12/84/47/360_F_112844774_6zjXJDtV6wPY9ReDOjv3coNm6lEI4vP0.jpg',
    },
    {
      'name': 'Tomato',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1PJFX0VdmpvFVbADdEp9R9QIIpHhDaWwOQQ&s',
    },
    // Add more vegetables as needed
  ];

  void _showVegetableDetails(Map<String, String> vegetable) {
    setState(() {
      _currentVegetableName = vegetable['name']!;
      _currentVegetableImage = vegetable['imageUrl']!;
      _message = 'Awesome!'; // O'zgartirilgan xabar
      _isTapped = !_isTapped;

      // Start confetti animation when a vegetable is tapped
      _confettiController.play();
    });

    // Reset after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTapped = false;
        _currentVegetableName = '';
        _currentVegetableImage = '';
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
        title: Text("Vegetables Game", style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),),
      ),
      body: Column(
        children: [
          // Animated container showing vegetable details
          if (_currentVegetableName.isNotEmpty)
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    _currentVegetableName,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.network(_currentVegetableImage, height: 100),
                ],
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
              itemCount: vegetables.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showVegetableDetails(vegetables[index]);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                      color: _isTapped
                          ? Colors.orange[50]
                          : Colors.green[50], // Change color on tap
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        vegetables[index]['name']!,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Message displayed at the bottom
          if (_message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                _message,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          // "Let's Go" button
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: InkWell(
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherPage())) ;// Implement action for "Let's Go" button
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
                    )
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
            colors: [Colors.green, Colors.yellow, Colors.blue],
          ),
        ],
      ),
    );
  }
}
