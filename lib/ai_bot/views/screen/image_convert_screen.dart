import 'dart:developer';
import 'dart:io';

import 'package:ai_bot/ai_bot/constants/app_colors.dart';
import 'package:ai_bot/ai_bot/views/widgets/pciker_button.dart';
import 'package:ai_bot/config/toast_config.dart';
import 'package:ai_bot/enums/toast_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ImageConvertScreen extends StatefulWidget {
  const ImageConvertScreen({super.key});

  @override
  State<ImageConvertScreen> createState() => _ImageConvertScreenState();
}

class _ImageConvertScreenState extends State<ImageConvertScreen>
    with WidgetsBindingObserver {
  File? image;
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kbackgroundColor,
        body: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            !textScanning && imageFile == null
                ? Image.asset(
                    'assets/images/Image_not_available.png',
                    width: 400.w,
                    height: 400.h,
                  )
                : Image.file(
                    File(imageFile!.path),
                    height: 200.h,
                    width: 300.h,
                  ),
            //to Pick image
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: image != null
                  ? FutureBuilder(
                      future: _extractText(image!),
                      builder: (context, snapshot) {
                        return Row(
                          children: [
                            SizedBox(
                                height: 290.h,
                                width: 290.w,
                                child: SelectableText(snapshot.data ?? '')),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                ToastConfig.showToast(
                                    msg: 'Copied',
                                    toastStates: ToastStates.Success);
                                Clipboard.setData(
                                    ClipboardData(text: scannedText));
                              },
                              child: scannedText.isNotEmpty
                                  ? Image.asset(
                                      'assets/images/copy.png',
                                      color: AppColors.kWhiteColor,
                                      height: 20.h,
                                      width: 20.w,
                                    )
                                  : const SizedBox(),
                            )
                          ],
                        );
                      })
                  : const SizedBox(),
            ),
            scannedText.isNotEmpty
                ? PickerButton(
                    function: () {},
                    text: 'Go To chat with this text',
                    isChatButton: true,
                  )
                : const SizedBox(),
            Spacer(
              flex: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: PickerButton(
                      function: () async {
                        try {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            textScanning = true;
                            imageFile = image;
                          }
                          if (image == null) return;
                          final imageTemp = File(image!.path);
                          setState(() => this.image = imageTemp);
                        } on PlatformException catch (e) {
                          ToastConfig.showToast(
                              msg: 'Error', toastStates: ToastStates.Error);
                          textScanning = false;
                          imageFile = null;
                          scannedText = 'Error occured while scanning';
                        }
                      },
                      text: 'Gallery'),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: PickerButton(
                      isFirst: false,
                      function: () async {
                        try {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (image != null) {
                            textScanning = true;
                            imageFile = image;
                          }
                          if (image == null) return;
                          final imageTemp = File(image.path);
                          setState(() => this.image = imageTemp);
                        } on PlatformException catch (e) {
                          ToastConfig.showToast(
                              msg: 'Error', toastStates: ToastStates.Error);
                          textScanning = false;
                          imageFile = null;
                          scannedText = 'Error occured while scanning';
                        }
                      },
                      text: 'Camera'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> _extractText(File file) async {
    final textRecognizer = TextRecognizer();
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    scannedText = recognizedText.text;
    log(recognizedText.text);
    textRecognizer.close();
    return recognizedText.text;
  }
}
