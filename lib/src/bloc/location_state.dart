import 'package:epaisa_pos/src/models/Location.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LocationState extends Equatable {
  LocationState([List props = const <dynamic>[]]) : super(props);
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Location location;

  LocationLoaded(this.location) : super([location]);
}
