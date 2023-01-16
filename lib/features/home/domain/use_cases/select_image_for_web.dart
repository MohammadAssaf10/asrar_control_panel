import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/xfile_entities.dart';

class SelectImageForWebUseCase {
  Future<XFileEntities?> call() async {
    final ImagePicker picker = ImagePicker();
    XFile? imagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      Uint8List selected = await imagePicked.readAsBytes();
      String selectedName = imagePicked.name;
      final XFileEntities xFileEntities =
          XFileEntities(name: selectedName, xFileAsBytes: selected);
      return xFileEntities;
    }
    return null;
  }
}
