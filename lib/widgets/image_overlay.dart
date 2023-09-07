import 'package:flutter/material.dart';

class CircularImageOverlay extends StatefulWidget {
  final String imageUrl;

  CircularImageOverlay({required this.imageUrl});

  @override
  _CircularImageOverlayState createState() => _CircularImageOverlayState();
}

class _CircularImageOverlayState extends State<CircularImageOverlay> {
  bool _isOverlayVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circular Image Overlay'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isOverlayVisible = !_isOverlayVisible;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.imageUrl),
                radius: 50.0, // Adjust the size as needed
              ),
              if (_isOverlayVisible)
                Container(
                  width: 200, // Adjust the size as needed
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.imageUrl),
                      radius: 80.0, // Adjust the size as needed
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
