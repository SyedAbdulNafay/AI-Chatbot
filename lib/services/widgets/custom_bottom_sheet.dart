import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          // Example background content
          const Center(child: Text("Background Content")),

          // Bottom sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: BottomSheetClipper(),
              child: Container(
                height: 300,
                color: Colors.white,
                child: const Column(
                  children: [
                    SizedBox(height: 40), // Space for the top with the handle
                    ListTile(
                      title: Text('System default'),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Light mode'),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Dark mode'),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Transparent handle area
          Positioned(
            top: MediaQuery.of(context).size.height - 300, // Adjust height
            left: MediaQuery.of(context).size.width / 2 - 20,
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 20); // Start at the top-left
    path.quadraticBezierTo(
        size.width / 3, 30, size.width, 20); // Curve in the middle
    path.lineTo(size.width, size.height); // Right side
    path.lineTo(0, size.height); // Bottom side
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
