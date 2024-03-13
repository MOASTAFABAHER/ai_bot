import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meta/meta.dart';
part 'gemini_state.dart';

class GeminiCubit extends Cubit<GeminiState> {
  GeminiCubit() : super(GeminiInitial());
  late final GenerativeModel model;
  late final ChatSession chat;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool loading = false;
  static GeminiCubit get(context) => BlocProvider.of(context);
  void startFunction() {
    model = GenerativeModel(
        model: 'gemini-pro', apiKey: 'AIzaSyCVvF-5qDywQQ3c4Mfi-LjFGwMZwaA6_1g');
    chat = model.startChat();
  }

  Future<void> sendChatMessage(String message) async {
    emit(SendMessageLoadingState());
    try {
      final response = await chat.sendMessage(Content.text(message));
      final text = response.text;
      if (text == null) {
        debugPrint('No response from API.');
        return;
      }
      loading = false;
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

