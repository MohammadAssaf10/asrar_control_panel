import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/values_manager.dart';
import '../../../chat/domain/entities/message.dart';
import 'image_network.dart';

class ImageMessageWidget extends StatelessWidget {
  const ImageMessageWidget({super.key, required this.message});

  final ImageMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: ImageNetwork(
          image: message.imageUrl,
          boxFit: BoxFit.cover,
          loadingHeight: AppSize.s25.h,
          loadingWidth: AppSize.s20.w,
        ),
      ),
    );
  }
}
