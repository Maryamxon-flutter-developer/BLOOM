import 'package:bloom/emage.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class OfficeItemsPage extends StatefulWidget {
  const OfficeItemsPage({super.key});

  @override
  State<OfficeItemsPage> createState() => _OfficeItemsPageState();
}

class _OfficeItemsPageState extends State<OfficeItemsPage> with SingleTickerProviderStateMixin {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  String _currentItem = '';
  String _currentItemImage = '';
  String _message = '';
  bool _isTapped = false;

  final List<Map<String, String>> officeItems = [
    {
      'item': 'Desk',
      'imageUrl': 'https://img.icons8.com/ios-filled/100/000000/desk.png',
    },
    {
      'item': 'Chair',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/501/501849.png',
    },
    {
      'item': 'Computer',
      'imageUrl': 'https://img.icons8.com/ios-filled/100/000000/computer.png',
    },
    {
      'item': 'Printer',
      'imageUrl': 'https://icon-library.com/images/printer-icon-png/printer-icon-png-9.jpg',
    },
    {
      'item': 'Scanner',
      'imageUrl': 'https://img.icons8.com/ios-filled/100/000000/scanner.png',
    },
    {
      'item': 'Projector',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/711/711315.png',
    },
  ];

  void _showItemDetails(Map<String, String> item) {
    setState(() {
      _currentItem = item['item']!;
      _currentItemImage = item['imageUrl']!;
      _message = 'Great choice!';
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
          "Office Items Game",
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
              itemCount: officeItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showItemDetails(officeItems[index]);
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
                          officeItems[index]['item']!,
                          style: TextStyle(fontSize: 24),
                        ),
                        if (_currentItem == officeItems[index]['item'])
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => EmotionsPage()));
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
