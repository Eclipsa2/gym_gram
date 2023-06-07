import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? file = await _imagePicker.pickImage(source: source, imageQuality: 50);

  CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

  if (croppedFile != null) {
    return await croppedFile.readAsBytes();
  }
  print('No image selected');
}


double deviceFontSize = 1;
double screenWidth = 1;
double screenHeight= 1;
double textScaleFactor = 1;

getScreenSize(BuildContext context) {
  final mediaQueryData = MediaQuery.of(context);
  textScaleFactor = mediaQueryData.textScaleFactor;
  final pixelRatio = mediaQueryData.devicePixelRatio;
  screenWidth = mediaQueryData.size.width;
  screenHeight = mediaQueryData.size.height;
  // Calculate the approximate device font size in pixels
  deviceFontSize = (screenWidth / pixelRatio) / textScaleFactor;

}