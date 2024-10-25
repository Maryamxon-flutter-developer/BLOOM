import 'package:bloom/tt.dart';
import 'package:flutter/material.dart';

import 'package:confetti/confetti.dart';


void main() {
  runApp(FruitGameApp());
}

class FruitGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fruit Game',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));
  
  String _message = '';
  String _currentFruitName = '';
  String _currentFruitImage = '';
  final GlobalKey _key = GlobalKey();

  void _checkAnswer(Fruit fruit) {
    setState(() {
      _currentFruitName = fruit.name; // Update current fruit name
      _currentFruitImage = fruit.imageUrl; // Update current fruit image
      if (fruit.name == 'Apple') { // Change 'Apple' to whatever fruit you want as correct
        _message = 'Well Done!';
        _confettiController.play();
      } else {
        _message = 'Try Again!';
      }
    });

    // Reset messages after a short delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _message = '';
        _currentFruitName = ''; // Clear current fruit name
        _currentFruitImage = ''; // Clear current fruit image
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit Game',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),),
      ),
      body: Column(
        children: [
          // Display the name and image of the tapped fruit
          if (_currentFruitName.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    _currentFruitName,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.network(_currentFruitImage, height: 100), // Display the image
                ],
              ),
            ),
          ],
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: fruits.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _checkAnswer(fruits[index]);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
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
                        fruits[index].name,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Display message
          if (_message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                _message,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> VegetablesPage()),);
                },
                child: Container(
                width: 300,
                height: 45,
                           
                
                child: Center(child: Text("Let's Go",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 69, 188),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(
                     color: Color.fromARGB(255, 7, 87, 24).withOpacity(0.2),
                offset: Offset(6, 7),
                blurRadius: 18,
                  )]
                ),
                ),
              ),
            ),
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

// Fruit class to store fruit data
class Fruit {
  final String name;
  final String imageUrl;

  Fruit({required this.name, required this.imageUrl});
}

// Sample fruit data
List<Fruit> fruits = [
  Fruit(
    name: 'Apple',
    imageUrl: 'https://img.clipart-library.com/2/clip-apple-fruit/clip-apple-fruit-12.png', // Replace with actual image URL
  ),
  Fruit(
    name: 'Orange',
    imageUrl: 'https://d2j6dbq0eux0bg.cloudfront.net/images/94614057/3982651423.webp', // Replace with actual image URL
  ),
  Fruit(
    name: 'Banana',
    imageUrl: 'https://images.everydayhealth.com/images/diet-nutrition/how-many-calories-are-in-a-banana-1440x810.jpg', // Replace with actual image URL
  ),
  Fruit(
    name: 'Grapes',
    imageUrl: 'https://5.imimg.com/data5/VU/MR/MY-24751011/purple-grapes.jpg', // Replace with actual image URL
  ),
  // Add more fruits as needed
];
