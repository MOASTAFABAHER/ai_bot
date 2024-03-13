part of 'voice_cubit.dart';

@immutable
sealed class VoiceState {}

final class VoiceInitial extends VoiceState {}
final class StartRecordingState extends VoiceState {}
final class ErrorRecordingState extends VoiceState {}
final class StopRecordingState extends VoiceState {}
