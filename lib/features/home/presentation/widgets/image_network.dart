import 'package:flutter/material.dart';

import 'loading_view.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({
    Key? key,
    required this.image,
    required this.loadingHeight,
    required this.loadingWidth,
    required this.boxFit,
    this.imageHeight,
    this.imageWidth,
  }) : super(key: key);
  final String image;
  final double loadingHeight;
  final double loadingWidth;
  final BoxFit boxFit;
  final double? imageHeight;
  final double? imageWidth;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: boxFit,
      height: imageHeight,
      width: imageWidth,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return LoadingView(
          height: loadingHeight,
          width: loadingWidth,
        );
      },
    );
  }
}
