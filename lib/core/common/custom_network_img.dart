import 'package:flutter/material.dart';
import '../constant/images_path.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final String fallbackAsset;
  final double borderRadius;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
    this.fallbackAsset = MyImages.boyAvatar,
    this.borderRadius = 50,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl ?? '',
        height: height,
        width: width,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child; // Image successfully loaded
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        errorBuilder: (context, error, stackTrace) {
          // Fallback image in case of error
          return Image.asset(
            fallbackAsset,
            height: height,
            width: width,
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
