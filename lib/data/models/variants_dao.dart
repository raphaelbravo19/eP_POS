import 'dart:convert' as JSON;

import 'package:epaisa_pos/data/database.dart';
import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'variants_dao.g.dart';

@UseDao(tables: [Variants])
class VariantsDao extends DatabaseAccessor<AppDatabase>
    with _$VariantsDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  VariantsDao(this.db) : super(db);

  Future<List<Variant>> getAll() => select(variants).get();

  Future<Variant> getOne(String id) {
    return (select(variants)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<Variant>> watchAll() => select(variants).watch();

  Future add(Variant data) => into(variants).insert(data);
  Future edit(Variant data) => update(variants).replace(data);
  Future remove(Variant data) => delete(variants).delete(data);

  static Variant fromMap(Map<String, dynamic> map) {
    print(map["price"].runtimeType);
    return Variant(
      id: map['id'],
      name: map['name'],
      attributes: JSON.jsonEncode(map['attributes']),
      inventory: map['inventory'],
      barcode: map['barcode'],
      cess: map['cess'],
      gst: map['gst'],
      price: map["price"].runtimeType != String
          ? map["price"].toDouble()
          : double.parse(map['price']),
      sku: map['sku'],
      mrp: map['mrp'],
      threshold: map['threshold'],
      vat: map['vat'],
      productId: map['productId'],
      merchantId: map['merchantId'],
      storeId: map['storeId'],
      status: map['status'],
    );
  }
}
