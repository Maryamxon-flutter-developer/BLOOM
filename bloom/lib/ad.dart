import 'package:bloom/zzx.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';



class ClothingPage extends StatefulWidget {
  const ClothingPage({super.key});

  @override
  State<ClothingPage> createState() => _ClothingPageState();
}

class _ClothingPageState extends State<ClothingPage> with SingleTickerProviderStateMixin {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  String _currentClothingItem = '';
  String _currentClothingImage = '';
  String _message = '';
  bool _isTapped = false;

  final List<Map<String, String>> clothingItems = [
    {
      'item': 'Hat',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8wXFU5sNsjcPlDHHastOyy8MpuA35JPCYAA&s', // Updated URL
    },
    {
      'item': 'Gloves',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUHKqmHALxXVUXqmyHH3BYxHU2CIg9IOuJqQ&s', // Updated URL
    },
    {
      'item': 'Jacket',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/jacket.png',
    },
    {
      'item': 'Scarf',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/scarf.png',
    },
    {
    'item': 'Bag',
    'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/backpack.png', // Alternate bag icon
  },
  {
    'item': 'Shoes',
    'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/shoes.png',
  },
    // Add more clothing items as needed
  ];

  void _showClothingDetails(Map<String, String> clothing) {
    setState(() {
      _currentClothingItem = clothing['item']!;
      _currentClothingImage = clothing['imageUrl']!;
      _message = 'Awesome!'; // Message when tapped
      _isTapped = true; // Set tapped state to true

      // Start confetti animation when a clothing item is tapped
      _confettiController.play();
    });

    // Reset after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTapped = false; // Reset tapped state
        _currentClothingItem = '';
        _currentClothingImage = ''; // Clear image after delay
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
          "Clothing Game",
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
              itemCount: clothingItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showClothingDetails(clothingItems[index]);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                      color: _isTapped ? Colors.orange[50] : Colors.pink[50],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Display the clothing item name
                        Text(
                          clothingItems[index]['item']!,
                          style: TextStyle(fontSize: 24),
                        ),
                        // Show the image only if it's the tapped item
                        if (_currentClothingItem == clothingItems[index]['item'])
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Image.network(_currentClothingImage, height: 60),
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
            padding: const EdgeInsets.only(bottom: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>HomeItemsPage()));// Implement action for "Let's Go" button
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
            colors: [Colors.pink, Colors.yellow, Colors.blue],
          ),
        ],
      ),
    );
  }
}
