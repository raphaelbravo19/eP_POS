import 'dart:convert';

import 'package:epaisa_pos/data/database.dart';
import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'products_dao.g.dart';

@UseDao(tables: [Products])
class ProductsDao extends DatabaseAccessor<AppDatabase>
    with _$ProductsDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  ProductsDao(this.db) : super(db);

  Future<List<Product>> getAll() => select(products).get();

  Future<Product> getOne(String id) {
    return (select(products)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<Product>> watchAll() => select(products).watch();

  Future add(Product data) => into(products).insert(data);
  Future edit(Product data) => update(products).replace(data);
  Future remove(Product data) => delete(products).delete(data);

  static Product fromMap(Map<String, dynamic> map) {
    String images = "";
    if (map["images"] != null) {
      for (var i = 0; i < map["images"].length; i++) {
        images += ",${map["images"][i]}";
      }
    }
    images = images.length > 0 ? images.substring(1) : "";
    return Product(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        merchantId: map['merchantId'],
        storeId: map['storeId'],
        unitId: map['storeId'],
        status: map['status'],
        hsn: map['hsn'],
        images: images,
        variants: json.encode(map['variants']),
        distributors: json.encode(map['distributors']),
        categories: json.encode(map['categories']),
        manufacturerId: map['manufacturerId']);
  }
}
