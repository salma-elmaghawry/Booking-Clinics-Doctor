import 'package:cached_network_image/cached_network_image.dart';
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
    this.fallbackAsset = MyImages.doctorAvatar,
    this.borderRadius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? "",
          width: width,
          height: height,
          errorListener: (val) {},
          fit: BoxFit.cover,
          errorWidget: (context, url, error) {
            return Image.asset(
              fallbackAsset,
              width: width,
              height: height,
              fit: BoxFit.cover,
            );
          },
        ),
        // child: Image.network(
        //   imageUrl ?? '',
        //   height: height,
        //   width: width,
        //   fit: BoxFit.cover,
        //   loadingBuilder: (context, child, loadingProgress) {
        //     if (loadingProgress == null) {
        //       return child; // Image successfully loaded
        //     } else {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //   },
        //   errorBuilder: (context, error, stackTrace) {
        //     // Fallback image in case of error
        //     return Image.asset(
        //       fallbackAsset,
        //       height: height,
        //       width: width,
        //       fit: BoxFit.cover,
        //     );
        //   },
        // ),
      ),
    );
  }
}
