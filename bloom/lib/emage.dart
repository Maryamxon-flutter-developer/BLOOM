import 'package:bloom/xc.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';


class EmotionsPage extends StatefulWidget {
  const EmotionsPage({super.key});

  @override
  State<EmotionsPage> createState() => _EmotionsPageState();
}

class _EmotionsPageState extends State<EmotionsPage> with SingleTickerProviderStateMixin {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  String _currentEmotion = '';
  String _currentEmotionImage = '';
  String _message = '';
  bool _isTapped = false;

  final List<Map<String, String>> emotions = [
    {
      'emotion': 'Happy 😊',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/happy.png',
    },
    {
      'emotion': 'Sad 😢',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/sad.png',
    },
    {
      'emotion': 'Angry 😠',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/angry.png',
    },
    {
      'emotion': 'Excited 🤩',
      'imageUrl': 'https://emojiisland.com/cdn/shop/products/Emoji_Icon_-_Smiling_medium.png?v=1571606089', // Yangi rasm
    },
     {
      'emotion': 'Love 😍',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/in-love.png',
    },
     {
      'emotion': 'Bored 😒',
      'imageUrl': 'https://img.icons8.com/ios-filled/50/000000/bored.png',
    },
  ];

  void _showEmotionDetails(Map<String, String> emotion) {
    setState(() {
      _currentEmotion = emotion['emotion']!;
      _currentEmotionImage = emotion['imageUrl']!; // Rasm URL'sini o'rnatish
      _message = 'That\'s cool!'; // Tapped holatidagi xabar
      _isTapped = true; // Tapped holatini true'ga o'rnatish

      // Tugmani bosganda konfetti animatsiyasi boshlanadi
      _confettiController.play();
    });

    // Bir necha soniyadan keyin o'chirish
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTapped = false; // Tapped holatini o'chirish
        _currentEmotion = '';
        _currentEmotionImage = ''; // Rasmni o'chirish
        _message = ''; // Xabarni o'chirish
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
          "Emotion Game",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
        ),
      ),
      body: Column(
        children: [
          // Xabarni pastda ko'rsatish
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
              itemCount: emotions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showEmotionDetails(emotions[index]);
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
                        // His-tuyg'u nomini ko'rsatish
                        Text(
                          emotions[index]['emotion']!,
                          style: TextStyle(fontSize: 24),
                        ),
                        // Agar tanlangan bo'lsa rasmni ko'rsatish
                        if (_currentEmotion == emotions[index]['emotion'])
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Image.network(_currentEmotionImage, height: 60),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // "Let's Go" tugmasi
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyWidget())); // Tugma harakati
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
          // Konfetti animatsiyasi
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: 3.14, // radial qiymat - π
            emissionFrequency: 0.05,
            numberOfParticles: 10,
            shouldLoop: false,
            colors: [Color.fromARGB(255, 38, 243, 219), Colors.yellow, Colors.red],
          ),
        ],
      ),
    );
  }
}
