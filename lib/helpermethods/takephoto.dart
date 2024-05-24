import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

import 'package:instaapp/cubit/cubit/authtecate_cubit.dart';

class Photo {
  Uint8List? pickedImgWeb;
  io.File? pickedImgMobile;

  Future<void> takeImage(BuildContext context, {VoidCallback? onPressed}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? result = await _picker.pickImage(source: ImageSource.gallery);

    if (result != null) {
      try {
        if (kIsWeb) {
          final bytes = await result.readAsBytes();
          pickedImgWeb = bytes;
          print('Image picked for web: ${pickedImgWeb?.length} bytes');
          BlocProvider.of<AuthtecateCubit>(context).getimgWeb(pickedImgWeb!);
        } else {
          final file = io.File(result.path);
          pickedImgMobile = file;
          print('Image picked for mobile: ${pickedImgMobile?.path}');
          BlocProvider.of<AuthtecateCubit>(context).getimgMobile(pickedImgMobile!);
        }
        if (onPressed != null) {
          onPressed();
        }
      } catch (e) {
        print('Error picking image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }
}
