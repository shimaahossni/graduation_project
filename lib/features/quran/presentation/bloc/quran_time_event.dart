// features/quran/presentation/bloc/quran_time_event.dart
part of 'quran_time_bloc.dart';

@immutable
sealed class QuranTimeEvent {}

class GetQuranTimeEvent extends QuranTimeEvent {
  QuranDetails? quranDetails;
}
