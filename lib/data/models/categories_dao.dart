import 'dart:convert' as JSON;

import 'package:epaisa_pos/data/database.dart';
import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'categories_dao.g.dart';

@UseDao(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriesDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  CategoriesDao(this.db) : super(db);

  Future<List<Categorie>> getAll() => select(categories).get();

  Future<Categorie> getOne(String id) {
    return (select(categories)..where((d) => d.id.equals(id))).getSingle();
  }

  Future<List<Categorie>> getParents() {
    return (select(categories)..where((d) => (isNull(d.parent)))).get();
  }

  Future<List<Categorie>> getSingles() {
    return (select(categories)..where((d) => (isNull(d.children)))).get();
  }

  Future<List<Categorie>> getChildren(String id) {
    return (select(categories)..where((d) => d.parent.equals(id))).get();
  }

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Stream<List<Categorie>> watchAll() => select(categories).watch();

  Future add(Categorie data) => into(categories).insert(data);
  Future edit(Categorie data) => update(categories).replace(data);
  Future remove(Categorie data) => delete(categories).delete(data);

  static Categorie fromMap(Map<String, dynamic> map) {
    String children;
    if (map['children'] != null) {
      print("CHILDREN END: ${map['children']}");
      children = "";
      for (var i = 0; i < map['children'].length; i++) {
        children += ("," + map['children'][i]);
      }
    }
    print("CHILDREN END: $children");
    return Categorie(
      id: map['id'],
      name: map['name'],
      merchantId: map['merchantId'],
      storeId: map['storeId'],
      color: map['color'],
      children: map['children'] != null
          ? children.length > 0 ? children.substring(1) : null
          : null,
      products: JSON.jsonEncode(map["products"] != null ? map["products"] : []),
      status: map['status'],
      parent: map['parent'],
    );
  }
}
