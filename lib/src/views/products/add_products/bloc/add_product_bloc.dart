import 'dart:async';
import 'dart:io';
import 'package:epaisa_pos/src/validators/Validator.dart';
import 'package:rxdart/rxdart.dart';

class AddProductBloc extends Object with Validators {
  final streamName = BehaviorSubject<String>.seeded("");
  final streamDescription = BehaviorSubject<String>.seeded("");
  final streamHsn = BehaviorSubject<String>.seeded("");
  final streamUnit = BehaviorSubject<String>();
  final streamCategories = BehaviorSubject<List<int>>();
  final streamDistributors = BehaviorSubject<List<int>>.seeded([]);
  final streamManufacturers = BehaviorSubject<String>();
  final streamVariants = BehaviorSubject<List<Map<String, dynamic>>>();
  final streamImage = BehaviorSubject<File>();
  final streamImageUrl = BehaviorSubject<String>();
  final streamImageChanged = BehaviorSubject<bool>.seeded(false);

  Stream<String> get name => streamName.stream;
  Stream<String> get description => streamDescription.stream;
  Stream<String> get hsn => streamHsn.stream;
  Stream<String> get unit => streamUnit.stream;
  Stream<String> get manufacturer => streamManufacturers.stream;
  Stream<List<int>> get categories => streamCategories.stream;
  Stream<List<int>> get distributor => streamDistributors.stream;
  //Stream<bool> get isValid =>
  //  Observable.combineLatest1(username, password, (us, pw) => true);

  Function(String) get changeName => streamName.sink.add;
  Function(String) get changeDescription => streamDescription.sink.add;
  Function(String) get changeUnit => streamUnit.sink.add;
  Function(String) get changeManufacturer => streamManufacturers.sink.add;
  Function(List<int>) get changeCategories => streamCategories.sink.add;
  Function(String) get changeHSN => streamHsn.sink.add;
  Function(List<int>) get changeDistributors => streamDistributors.sink.add;
  Function(List<Map<String, dynamic>>) get changeVariants =>
      streamVariants.sink.add;
  Function(File) get changeImage => streamImage.sink.add;
  Function(String) get changeImageUrl => streamImageUrl.sink.add;
  Function(bool) get changeImageChanged => streamImageChanged.sink.add;

  dispose() {
    print('dispose');
    streamName.close();
    streamUnit.close();
    streamDistributors.close();
    streamDescription.close();
    streamHsn.close();
    streamManufacturers.close();
    streamCategories.close();
    streamVariants.close();
    streamImage.close();
    streamImageChanged.close();
    streamImageUrl.close();
  }
}
