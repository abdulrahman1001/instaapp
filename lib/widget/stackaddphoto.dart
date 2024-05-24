import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:io' as io show File;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:instaapp/cubit/cubit/authtecate_cubit.dart';

class StackAddPhoto extends StatefulWidget {
  const StackAddPhoto({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  State<StackAddPhoto> createState() => _StackAddPhotoState();
}

class _StackAddPhotoState extends State<StackAddPhoto> {
  Uint8List? pickedImgWeb;
  io.File? pickedImgMobile;

  Future<void> takeImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? result = await _picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      if (kIsWeb) {
        final bytes = await result.readAsBytes();
        setState(() {
          pickedImgWeb = bytes;
        });
        BlocProvider.of<AuthtecateCubit>(context).getimgWeb(pickedImgWeb!);
      } else {
        final file = io.File(result.path);
        setState(() {
          pickedImgMobile = file;
        });
        BlocProvider.of<AuthtecateCubit>(context).getimgMobile(pickedImgMobile!);
      }
      if (widget.onPressed != null) {
        widget.onPressed!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? imageProvider;
    if (kIsWeb) {
      imageProvider = pickedImgWeb != null
          ? MemoryImage(pickedImgWeb!) as ImageProvider<Object>
          : NetworkImage('https://www.gstatic.com/webp/gallery/1.jpg') as ImageProvider<Object>;
    } else {
      imageProvider = pickedImgMobile != null
          ? FileImage(pickedImgMobile!) as ImageProvider<Object>
          : NetworkImage('https://www.gstatic.com/webp/gallery/1.jpg') as ImageProvider<Object>;
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: imageProvider,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            onPressed: takeImage,
            icon: Icon(Icons.add_a_photo),
          ),
        ),
      ],
    );
  }
}
