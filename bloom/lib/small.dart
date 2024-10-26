
import 'package:bloom/xc.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class FavoriteQuotesPage extends StatefulWidget {
  const FavoriteQuotesPage({super.key});

  @override
  State<FavoriteQuotesPage> createState() => _FavoriteQuotesPageState();
}

class _FavoriteQuotesPageState extends State<FavoriteQuotesPage> with SingleTickerProviderStateMixin {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  String _currentQuote = '';
  String _currentQuoteImage = '';
  String _message = '';
  bool _isTapped = false;

  final List<Map<String, String>> favoriteQuotes = [
    {
      'quote': 'Believe in yourself!',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2804/2804199.png',
    },
    {
      'quote': 'Stay positive',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/5269/5269898.png',
    },
    {
      'quote': 'Keep learning',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2452/2452184.png',
    },
    {
      'quote': 'Be grateful',
      'imageUrl': 'https://static.thenounproject.com/png/3068034-200.png',
    },
    {
      'quote': 'Dream big',
      'imageUrl': 'https://cdn4.iconfinder.com/data/icons/project-management-1-11/65/29-512.png',
    },
    {
      'quote': 'Take action',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/9196/9196093.png',
    },
    // Add more quotes as needed
  ];

  void _showQuoteDetails(Map<String, String> quote) {
    setState(() {
      _currentQuote = quote['quote']!;
      _currentQuoteImage = quote['imageUrl']!;
      _message = 'Inspiring choice!';
      _isTapped = true;

      _confettiController.play();
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTapped = false;
        _currentQuote = '';
        _currentQuoteImage = '';
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
          "Favorite Quotes",
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
              itemCount: favoriteQuotes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showQuoteDetails(favoriteQuotes[index]);
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
                          favoriteQuotes[index]['quote']!,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        if (_currentQuote == favoriteQuotes[index]['quote'])
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Image.network(_currentQuoteImage, height: 60),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyWidget())); // Implement action for "Let's Go" button
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
