import '../../base/base_dao.dart';
import 'merchant.dart';
import '../database/user_db.dart';
import 'merchant_builder.dart';
import 'merchant_constant.dart';

class MerchantDao extends Dao<Merchant> {
  MerchantDao() : super(new UserDb(), new MerchantBuilder());

  @override
  String getTableName() {
    return TABLE_NAME;
  }
}
