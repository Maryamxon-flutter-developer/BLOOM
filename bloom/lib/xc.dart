import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  String _message = '';
  bool _isTapped = false;

  void _onContainerTapped() {
    setState(() {
      _message = 'Great Choice! 🎉'; // Set the message when tapped
      _isTapped = true; // Change tapped state to true

      // Start confetti animation
      _confettiController.play();
    });

    // Clear message and tapped state after a few seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTapped = false; // Reset tapped state
        _message = ''; // Clear the message
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "👍👍👍👍👍👍👍",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // Display the message at the top
          if (_message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                _message,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: _onContainerTapped,
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
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Text(
                      "Tap Me!",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Confetti animation
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: 3.14, // radians
            emissionFrequency: 0.05,
            numberOfParticles: 10,
            shouldLoop: false,
            colors: [Colors.green, Colors.yellow, Colors.red],
          ),
        ],
      ),
    );
  }
}
