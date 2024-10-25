import 'package:bloom/emage.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';


class HomeItemsPage extends StatefulWidget {
  const HomeItemsPage({super.key});

  @override
  State<HomeItemsPage> createState() => _HomeItemsPageState();
}

class _HomeItemsPageState extends State<HomeItemsPage> with SingleTickerProviderStateMixin {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  String _currentItem = '';
  String _currentItemImage = '';
  String _message = '';
  bool _isTapped = false;

  final List<Map<String, String>> homeItems = [
    {
      'item': 'TV',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/tv.png',
    },
    {
      'item': 'Phone',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/phone.png',
    },
    {
      'item': 'Laptop',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/laptop.png',
    },
    {
      'item': 'Washing ',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/washing-machine.png',
    },
     {
      'item': ' VacuumCleaner',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/vacuum-cleaner.png',
    },
    {
      'item': 'Toaster',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/toaster.png',
    },
    // Add more items as needed
  ];

  void _showItemDetails(Map<String, String> item) {
    setState(() {
      _currentItem = item['item']!;
      _currentItemImage = item['imageUrl']!;
      _message = 'Nice choice!';
      _isTapped = true;

      _confettiController.play();
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTapped = false;
        _currentItem = '';
        _currentItemImage = '';
        _message = '';
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
          "Home Items Game",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
        ),
      ),
      body: Column(
        children: [
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
              itemCount: homeItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showItemDetails(homeItems[index]);
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
                        Text(
                          homeItems[index]['item']!,
                          style: TextStyle(fontSize: 24),
                        ),
                        if (_currentItem == homeItems[index]['item'])
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Image.network(_currentItemImage, height: 60),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: InkWell(
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=> EmotionsPage())) ;// Implement action for "Let's Go" button
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
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: 3.14,
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
