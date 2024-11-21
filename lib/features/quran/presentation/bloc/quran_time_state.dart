// features/quran/presentation/bloc/quran_time_state.dart
part of 'quran_time_bloc.dart';

@immutable
sealed class QuranTimeState {}

final class QuranTimeInitial extends QuranTimeState {}

////quran state

final class QuranTimeSuccess extends QuranTimeState {}

final class QuranTimeLoaded extends QuranTimeState {}

final class QuranTimeError extends QuranTimeState {
  final String message;

  QuranTimeError({required this.message});
}
