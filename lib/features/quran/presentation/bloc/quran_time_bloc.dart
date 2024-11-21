// features/quran/presentation/bloc/quran_time_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:islami/features/quran/data/repo/quran_repo.dart';
import 'package:meta/meta.dart';
import '../../data/models/response/quran_details/quran_details.dart';
import '../../data/models/response/quran_details/surah.dart';
part 'quran_time_event.dart';
part 'quran_time_state.dart';

class QuranTimeBloc extends Bloc<QuranTimeEvent, QuranTimeState> {
  QuranTimeBloc() : super(QuranTimeInitial()) {
    on<GetQuranTimeEvent>(loadQuran);
  }

  List<Surah> surahs = [];

  loadQuran(GetQuranTimeEvent event, Emitter<QuranTimeState> emit) async {
    emit(QuranTimeLoaded());
    try {
      await QuranRepo.loadQuran().then((value) {
        if (value != null) {
          surahs = value.data?.surahs ?? [];
          emit(QuranTimeSuccess());
        } else {
          emit(QuranTimeError(message: "Error in loading Quran"));
        }
      });
    } on Exception catch (e) {
      emit(QuranTimeError(message: e.toString()));
    }
  }
}
