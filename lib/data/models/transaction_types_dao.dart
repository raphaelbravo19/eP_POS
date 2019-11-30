import 'dart:convert';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'transaction_types_dao.g.dart';

@UseDao(tables: [TransactionTypes])
class TransactionTypesDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionTypesDaoMixin {
  final AppDatabase db;

//   // Called by the AppDatabase class
  TransactionTypesDao(this.db) : super(db);

  Future<List<TransactionType>> getAll() => select(transactionTypes).get();

  Future<bool> exists(String id) async {
    return await getOne(id) != null;
  }

  Future<TransactionType> getOne(String id) {
    return (select(transactionTypes)..where((d) => d.id.equals(id)))
        .getSingle();
  }

  Stream<List<TransactionType>> watchAllTransactionTypes() =>
      select(transactionTypes).watch();

  Future add(TransactionType data) => into(transactionTypes).insert(data);
  Future edit(TransactionType data) => update(transactionTypes).replace(data);
  Future remove(TransactionType data) => delete(transactionTypes).delete(data);
  static TransactionType fromMap(Map<String, dynamic> map) {
    return TransactionType(
      id: map['id'],
      name: map['name'],
      displayName: map['displayName'],
      parentId: map['parentId'],
      providerCommision: map['providerCommision'],
      epaisaCommision: map['epaisaCommision'],
      mdr: map['mdr'],
      credentials: json.encode(map['credentials']),
      extraFields: json.encode(map['extraFields']),
      serviceTax: map['serviceTax'],
    );
  }
}
