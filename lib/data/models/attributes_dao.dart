import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'attributes_dao.g.dart';

@UseDao(tables: [ProductAttributes])
class ProductAttributesDao extends DatabaseAccessor<AppDatabase>
    with _$ProductAttributesDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  ProductAttributesDao(this.db) : super(db);

  Future<List<ProductAttribute>> getAll() => select(productAttributes).get();
  Future<ProductAttribute> getOne(String id) {
    return (select(productAttributes)..where((d) => d.id.equals(id)))
        .getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<ProductAttribute>> watchAll() =>
      select(productAttributes).watch();

  Future add(ProductAttribute data) => into(productAttributes).insert(data);
  Future edit(ProductAttribute data) => update(productAttributes).replace(data);
  Future remove(ProductAttribute data) =>
      delete(productAttributes).delete(data);

  static ProductAttribute fromMap(Map<String, dynamic> map) {
    return ProductAttribute(
        id: map['id'],
        name: map['name'],
        isVariant: map['isVariant'],
        isRequired: map['isRequired'],
        position: map['position'],
        type: map['type'],
        industryId: map['industryId'],
        status: map["status"]);
  }
}
