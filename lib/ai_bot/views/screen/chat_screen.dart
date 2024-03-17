import 'package:ai_bot/ai_bot/constants/app_colors.dart';
import 'package:ai_bot/ai_bot/views/widgets/message_text.dart';
import 'package:ai_bot/bloc/gemini/gemini_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    try {
      GeminiCubit.get(context).startFunction();
    } catch (e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeminiCubit, GeminiState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = GeminiCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.kbackgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.kbackgroundColor,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.kWhiteColor,
                )),
            title: Text(
              'Chat with AI bot',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kWhiteColor),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView.builder(
                  controller: cubit.scrollController,
                  itemBuilder: (context, index) {
                    final content = cubit.chat.history.toList()[index];
                    final text = content.parts
                        .whereType<TextPart>()
                        .map<String>((e) => e.text)
                        .join('');
                    return MessageWidget(
                      text: text,
                      isFromUser: content.role == 'user',
                    );
                  },
                  itemCount: cubit.chat.history.length,
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 15,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cubit.textEditingController,
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.sp),
                            hintText: 'Enter a prompt...',
                            hintStyle:
                                const TextStyle(color: AppColors.kWhiteColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14.sp),
                              ),
                              borderSide: const BorderSide(
                                color: AppColors.kWhiteColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14.sp),
                              ),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                          onFieldSubmitted: (String value) {
                            cubit.sendChatMessage(value);
                          },
                        ),
                      ),
                      const SizedBox.square(
                        dimension: 15,
                      ),
                      cubit.loading == false
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    cubit.isListing
                                        ? cubit.stopListening()
                                        : cubit.startRecording();
                                    cubit.textEditingController.text =
                                        cubit.recognizedText;
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                    radius: 20.sp,
                                    backgroundColor: AppColors.kbackgroundColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(2.sp),
                                      child: Icon(
                                        cubit.isListing
                                            ? Icons.stop
                                            : Icons.mic,
                                        size: 25.sp,
                                        color: AppColors.kSecondaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    cubit.sendChatMessage(
                                        cubit.textEditingController.text);
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ),
                              ],
                            )
                          : const CircularProgressIndicator(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
