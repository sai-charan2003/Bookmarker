import 'package:bookmarker/ui/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For closing the app

class Bookmarkaddedscreen extends StatelessWidget {
  const Bookmarkaddedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 100,
          ),
          const SizedBox(height: 20),
          
          const Text(
            'Bookmark Added',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Homescreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Go to Bookmarks'),
              ),
              const SizedBox(width: 20),
              
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Close App'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
