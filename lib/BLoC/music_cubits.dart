import 'package:bloc/bloc.dart';
import 'package:musixmatch_app/models/trending_track.dart';
// import 'package:travel_app/cubit/app_cubit_states.dart';
// import 'package:travel_app/services/data_services.dart';

// import '../model/data_model.dart';
import '../services/api_provider.dart';
import 'music_cubit_states.dart';

class MusicCubits extends Cubit<CubitStates> {
  MusicCubits() : super(InitialState());

  final DataServices data = DataServices();
  late final tracks;
  late final lyrics;

  void getData() async {
    emit(LoadingState());
    try {
      tracks = await data.fetchMusicList();
      emit(LoadedState(tracks));
    } catch (e) {}
  }

  void detailScreen(DataModel track) {
    emit(DetailState(track));
  }

  goHome() {
    emit(LoadedState(tracks));
  }
}
