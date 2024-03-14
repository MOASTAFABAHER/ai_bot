part of 'gemini_cubit.dart';

@immutable
sealed class GeminiState {}

final class GeminiInitial extends GeminiState {}

final class SendMessageSucssesState extends GeminiState {}

final class SendMessageErrorState extends GeminiState {}

final class SendMessageLoadingState extends GeminiState {}
final class StartRecordingState extends GeminiState {}
final class ErrorRecordingState extends GeminiState {}
final class StopRecordingState extends GeminiState {}
