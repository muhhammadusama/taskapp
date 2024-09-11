import 'package:flutter/material.dart';
import 'package:personal_home_app/screens/wrapper.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/startbackground.jpg"), // Add your image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50), // Top padding
                // Conference Title
                const Text(
                  'THE HOME APP\nSTART SCREEN',
                  style: TextStyle(
                    color: Colors.tealAccent,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 50),

                // Conference Info
                Text(
                  'This App is Design Specially To Keep Track For Surah Yaseen',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 50),

                // Conference Description
                Text(
                  'Please Join by clicking the start button',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 18,
                  ),
                ),
                const Spacer(), // Push button to the bottom

                // Buy Ticket Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add ticket purchase functionality
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Wrapper()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'START',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50), // Bottom padding
              ],
            ),
          ),
        ],
      ),
    );
  }
}
