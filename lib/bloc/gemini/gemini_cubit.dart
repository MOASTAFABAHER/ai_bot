import 'dart:developer';

import 'package:ai_bot/ai_bot/constants/keys.dart';
import 'package:ai_bot/config/toast_config.dart';
import 'package:ai_bot/enums/toast_status.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_to_text.dart';
part 'gemini_state.dart';

class GeminiCubit extends Cubit<GeminiState> {
  GeminiCubit() : super(GeminiInitial());
  late final GenerativeModel model;
  late final ChatSession chat;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

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
          listenFor: const Duration(seconds: 20),
          onResult: (result) {
            log('Yes');
            textEditingController.text = result.recognizedWords;
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

  bool loading = false;
  static GeminiCubit get(context) => BlocProvider.of(context);
  void startFunction() {
    model = GenerativeModel(
        model: 'gemini-pro', apiKey: Keys.apiKey);
    chat = model.startChat();
  }
  Future<void> sendChatMessage(String message) async {
    loading = true;
    log('Emit loading');

    emit(SendMessageLoadingState());
    try {
      final response = await chat.sendMessage(Content.text(message));
      final text = response.text;
      if (text == null) {
        debugPrint('No response from API.');
        return;
      }
      loading = false;
      log('Emit Suc');
      emit(SendMessageSucssesState());
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
    } finally {
      textEditingController.clear();
      loading = false;
      emit(SendMessageErrorState());
    }
  }
}
// Access your API key as an environment variable (see "Set up your API key" above)

