import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String image;

  const AppImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Builder(
        builder: (context) {
          if (image.endsWith(".svg")) {
            return SvgPicture.asset(image);
          }

          if (image.endsWith(".png")) {
            return Image.asset(
              image,
              fit: BoxFit.cover,
            );
          }
          return _errorWidget();
        },
      ),
    );
  }
}
Widget _errorWidget() {
  return Container(
    color: Colors.grey[200],
    alignment: Alignment.center,
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.broken_image, size: 48),
        const SizedBox(height: 8),
        const Text('Image load error'),
        const SizedBox(height: 4),

      ],
    ),
  );
}
