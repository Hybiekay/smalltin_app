import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smalltin/core/constants/app_images.dart';
import 'package:smalltin/themes/color.dart';
import 'package:encrypt/encrypt.dart' as encrypt; // Import the encrypt package

String getLogo(BuildContext context) {
  return context.isDarkMode ? AppImages.darkModeLogo : AppImages.logoPath;
}

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor"; // Add the alpha value if not present
  }
  return Color(int.parse(hexColor, radix: 16));
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

String formatTime(int seconds) {
  final minutes = seconds ~/ 60;
  final remainingSeconds = seconds % 60;
  return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
}

Future<File?> pickProfileImage(ImageSource source) async {
  var file = await ImagePicker().pickImage(source: source);

  if (file != null) {
    var crop = await ImageCropper().cropImage(
      sourcePath: file.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Edit Image',
          toolbarColor: AppColor.scaffoldBg,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Edit Image',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );

    if (crop != null) {
      return File(crop.path);
    }
  }
  return null;
}

// Function to encrypt the data
String encryptData(String plainText, String keyString) {
  final key = encrypt.Key.fromUtf8(keyString); // 32-byte key for AES-256
  final iv = encrypt.IV.fromSecureRandom(16); // Generate a random 16-byte IV

  final encrypter = encrypt.Encrypter(encrypt.AES(key));
  final encrypted = encrypter.encrypt(plainText, iv: iv);

  // Combine IV and encrypted data for storage, separated by a colon
  return '${iv.base64}:${encrypted.base64}';
}

// Function to decrypt the data
String decryptData(String encryptedDataWithIv, String keyString) {
  final key = encrypt.Key.fromUtf8(keyString); // 32-byte key for AES-256

  // Split the stored data to extract IV and encrypted data
  final parts = encryptedDataWithIv.split(':');
  final iv = encrypt.IV.fromBase64(parts[0]); // Extract the IV
  final encryptedData = parts[1]; // Extract the encrypted data

  final encrypter = encrypt.Encrypter(encrypt.AES(key));
  final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
  return decrypted; // Return the decrypted plain text
}

//  extention BoxConstraintss on  BoxConstraints {}

extension ResponsiveCheck on BoxConstraints {
  bool get isLargeScreen => maxWidth >= 600;
  bool get isMediemScreen => maxWidth >= 360;
  bool get isPhoneScreen => maxWidth <= 360;
}
