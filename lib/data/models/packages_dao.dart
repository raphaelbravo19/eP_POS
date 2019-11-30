import 'dart:convert' as JSON;

import 'package:epaisa_pos/data/database.dart';
import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'packages_dao.g.dart';

@UseDao(tables: [Packages])
class PackagesDao extends DatabaseAccessor<AppDatabase>
    with _$PackagesDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  PackagesDao(this.db) : super(db);

  Future<List<Package>> getAll() => select(packages).get();

  Future<Package> getOne(String id) {
    return (select(packages)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<Package>> watchAll() => select(packages).watch();

  Future add(Package data) => into(packages).insert(data);
  Future edit(Package data) => update(packages).replace(data);
  Future remove(Package data) => delete(packages).delete(data);

  static Package fromMap(Map<String, dynamic> map) {
    /*String children;
    if (map['products'] != null) {
      children = "";
      for (var i = 0; i < map['products'].length; i++) {
        children += ("," + map['products'][i]);
      }
    }*/
    String list = "";
    if (map["list"] != null && map["list"] != "") {
      list = JSON.jsonEncode(map["list"]);
    }
    String categories = map["categories"] is List ? "" : map["categories"];
    if (map["categories"] != null &&
        map["categories"] != "" &&
        map["categories"] is List) {
      for (var i = 0; i < map["categories"].length; i++) {
        categories += ("," + map["categories"][i].toString());
      }
      categories = categories.substring(1);
    }
    print("PACKAGE $categories");
    return Package(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      barcode: map['barcode'],
      inventory: map['inventory'],
      categories: categories,
      isGst: map['isGst'],
      isVat: map['isVat'],
      cess: map['cess'],
      gst: map['gst'],
      price: map['price'].toDouble(),
      sku: map['sku'],
      list: list,
      threshold: map['threshold'],
      vat: map['vat'],
      localId: map['localId'],
      unitId: map['unitId'],
      merchantId: map['merchantId'],
      storeId: map['storeId'],
      status: map['status'],
    );
  }
}
