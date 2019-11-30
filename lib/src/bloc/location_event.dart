import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LocationEvent extends Equatable {
  LocationEvent([List props = const <dynamic>[]]) : super(props);
}

class GetLocation extends LocationEvent {
  final BuildContext context;
  GetLocation(this.context) : super([context]);
}

class StopLocation extends LocationEvent {}
