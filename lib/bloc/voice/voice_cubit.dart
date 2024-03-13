import 'dart:developer';

import 'package:ai_bot/config/toast_config.dart';
import 'package:ai_bot/enums/toast_status.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'voice_state.dart';

class VoiceCubit extends Cubit<VoiceState> {
  VoiceCubit() : super(VoiceInitial());
  static VoiceCubit get(context) => BlocProvider.of(context);
  SpeechToText speechToText = SpeechToText();
  bool isListing = false;
  String recognizedText = 'Please Click on the mic to start recording';
  void checkMic() async {
    bool micAvailable = await speechToText.initialize();
    !micAvailable
        ? ToastConfig.showToast(
            msg: 'Please give permission to mic',
            toastStates: ToastStates.Warning)
        : const SizedBox();
  }

  void startRecording() async {
    bool micAvailable = await speechToText.initialize();
    if (micAvailable) {
      isListing = true;

      speechToText.listen(
          listenFor: Duration(seconds: 20),
          onResult: (result) {
          log('Yes');
            recognizedText = result.recognizedWords;

            isListing = false;
            emit(StartRecordingState());
          });
      emit(StartRecordingState());
    } else {
      ToastConfig.showToast(msg: 'Error', toastStates: ToastStates.Error);
      emit(ErrorRecordingState());
    }
  }

  void stopListening() async {
    await speechToText.stop();
    isListing = false;
    emit(StopRecordingState());
  }
}
