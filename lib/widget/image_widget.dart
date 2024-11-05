// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  const ImageWidget({
    super.key,
    this.width,
    this.color,
    required this.imagePath,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return imagePath.getimageType() == ImageType.network
        ? CachedNetworkImage(
            fit: fit,
            imageUrl: imagePath,
            width: width,
            height: height,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            progressIndicatorBuilder: (context, url, progress) =>
                const Icon(Icons.image),
          )
        : imagePath.getimageType() == ImageType.svg
            ? SvgPicture.asset(
                imagePath,
                height: height,
                width: width,
                color: color,
              )
            : imagePath.getimageType() == ImageType.png
                ? Image.asset(
                    imagePath,
                    height: height,
                    width: width,
                    fit: fit,
                  )
                : Image.asset(
                    imagePath,
                    height: height,
                    width: width,
                    fit: fit,
                  );
  }
}

enum ImageType { network, png, svg, jpeg }

extension CheckTheImageType on String {
  ImageType getimageType() {
    if (startsWith("http")) {
      return ImageType.network;
    } else if (endsWith("svg")) {
      return ImageType.svg;
    } else if (endsWith("png")) {
      return ImageType.png;
    } else {
      return ImageType.jpeg;
    }
  }
}
