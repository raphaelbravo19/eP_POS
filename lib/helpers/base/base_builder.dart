import 'base_model.dart';

abstract class Builder<T extends Model> {
  Builder<T> id(String id);

  Builder<T> localId(String localId);

  Builder<T> name(String name);

  Builder<T> isSynced(bool isSynced);

  Builder<T> status(int status);

  Builder<T> merchantId(String merchantId);

  Builder<T> createdAt(int createdAt);

  Builder<T> updatedAt(int updatedAt);

  Map<String, dynamic> buildMap();

  Map<String, dynamic> buildMapFromJson(Map<String, dynamic> json);

  Builder<T> fromMap(Map<String, dynamic> map);

  Builder<T> fromJson(Map<String, dynamic> map);

  Builder<T> setModel(T model);

  T build();
}
