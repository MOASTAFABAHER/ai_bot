import 'dart:developer';
import 'dart:io';

import 'package:ai_bot/ai_bot/constants/app_colors.dart';
import 'package:ai_bot/ai_bot/views/screen/chat_screen.dart';
import 'package:ai_bot/ai_bot/views/widgets/pciker_button.dart';
import 'package:ai_bot/bloc/gemini/gemini_cubit.dart';
import 'package:ai_bot/config/toast_config.dart';
import 'package:ai_bot/enums/toast_status.dart';
import 'package:ai_bot/utils/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

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
  FlutterTts flutterTts = FlutterTts();
  bool isNotePlaying = true;
  String _pdfFilePath = '';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    log('Dispodes');
    isNotePlaying = true;
    flutterTts.stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      isNotePlaying = true;
      flutterTts.stop();
      log('yest');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.kbackgroundColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.kWhiteColor,
              )),
          title: Text(
            'Image convert to text',
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.kWhiteColor),
          ),
        ),
        backgroundColor: AppColors.kbackgroundColor,
        body: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            !textScanning && imageFile == null
                ? Column(
                    children: [
                      Image.asset(
                        'assets/images/image_convert.png',
                        width: 400.w,
                      ),
                      Text(
                        'Upload or Take image',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.h,
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
                                    final imageTemp = File(image.path);
                                    setState(() => this.image = imageTemp);
                                  } on PlatformException catch (e) {
                                    log(e.toString());
                                    ToastConfig.showToast(
                                        msg: 'Error',
                                        toastStates: ToastStates.Error);
                                    textScanning = false;
                                    imageFile = null;
                                    scannedText =
                                        'Error occured while scanning';
                                  }
                                },
                                text: 'Gallery'),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            child: PickerButton(
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
                                    log(e.toString());
                                    ToastConfig.showToast(
                                        msg: 'Error',
                                        toastStates: ToastStates.Error);
                                    textScanning = false;
                                    imageFile = null;
                                    scannedText =
                                        'Error occured while scanning';
                                  }
                                },
                                text: 'Camera'),
                          )
                        ],
                      )
                    ],
                  )
                : Stack(
                    children: [
                      Image.file(
                        File(imageFile!.path),
                        height: 200.h,
                        width: 300.h,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              textScanning = false;
                              imageFile = null;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: AppColors.kWhiteColor,
                              size: 24.sp,
                            )),
                      )
                    ],
                  ),
            //to Pick image
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: image != null && textScanning
                  ? FutureBuilder(
                      future: _extractText(image!),
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    height: 280.h,
                                    width: 265.w,
                                    child: SelectableText(snapshot.data ?? '')),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Column(
                                  children: [
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
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {});
                                        isNotePlaying = !isNotePlaying;
                                        if (!isNotePlaying) {
                                          await flutterTts.setLanguage('en');
                                          await flutterTts.setSpeechRate(0.7);
                                          await flutterTts.speak(scannedText);
                                        } else {
                                          await flutterTts.stop();
                                        }
                                      },
                                      child: scannedText.isNotEmpty
                                          ? Image.asset(
                                              !isNotePlaying
                                                  ? 'assets/images/stop.png'
                                                  : 'assets/images/play-button.png',
                                              color: AppColors.kWhiteColor,
                                              height: 20.h,
                                              width: 20.w,
                                            )
                                          : const SizedBox(),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        File pdfFile =
                                            await createPDF(scannedText);
                                        await _openPdf();
                                      },
                                      child: scannedText.isNotEmpty
                                          ? Image.asset(
                                              'assets/images/download_button.png',
                                              color: AppColors.kWhiteColor,
                                              height: 20.h,
                                              width: 20.w,
                                            )
                                          : const SizedBox(),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            scannedText.isNotEmpty
                                ? PickerButton(
                                    isCahtbutton: true,
                                    function: () {
                                      GeminiCubit.get(context)
                                          .textEditingController
                                          .text = scannedText;
                                      AppNavigator.appNavigator(
                                          context, const ChatScreen());
                                    },
                                    text: 'Go To chat with this text',
                                  )
                                : const SizedBox(),
                          ],
                        );
                      })
                  : const SizedBox(),
            ),
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

  Future<File> createPDF(String text) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(scannedText),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/${scannedText.substring(0, 6)}.pdf');
    await file.writeAsBytes(await pdf.save());
    log(output.path.toString());
    _pdfFilePath = file.path;

    log('Saved ${file.path}');
    return file;
  }

  Future<void> _openPdf() async {
    if (_pdfFilePath.isNotEmpty) {
      OpenFile.open(_pdfFilePath);
    }
  }
}
