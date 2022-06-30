import 'package:equatable/equatable.dart';

import '../models/trending_track.dart';

abstract class CubitStates extends Equatable {}

class InitialState extends CubitStates {
  @override
  List<Object> get props => [];
}

class LoadingState extends CubitStates {
  @override
  List<Object> get props => [];
}

class LoadedState extends CubitStates {
  LoadedState(this.tracks);
  final List<DataModel> tracks;

  @override
  List<Object> get props => [tracks];
}

class DetailState extends CubitStates {
  DetailState(this.track);
  final DataModel track;
  @override
  List<Object> get props => [track];
}
