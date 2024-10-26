import 'package:bloom/fruit.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BloomPage(),
      ),
    );
  }
}

class BloomPage extends StatefulWidget {
  @override
  _BloomPageState createState() => _BloomPageState();
}

class _BloomPageState extends State<BloomPage> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the animation
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0; // Show after 1 second
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://play-lh.googleusercontent.com/qZek3UcRj7ZYPNIaGqiFr5COhjkHzb1huEpyykiovzK9nBKB381mmyDy-LNEQ9uW4w'), // Replace with your image URL
          fit: BoxFit.cover, // Cover the entire screen
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 2),
              child: Text(
                'Bloom',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 35, 230, 58),
                ),
              ),
            ),
            SizedBox(height: 30),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateX(0.1)..rotateY(0.1),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FruitGameApp()),
                  ); // Action when the button is tapped
                  print('Button Tapped!');
                },
                child: Container(
                  width: 300,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 227, 63, 178),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // Right and bottom shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Tap Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
