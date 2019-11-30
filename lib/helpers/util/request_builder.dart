import 'crypto_des.dart';
import 'logger.dart';

const String _SEPERATOR = '####';

class RequestBuilder {
  StringBuffer _request = StringBuffer();

  RequestBuilder addParameter(var param) {
    _request.write(param);
    _request.write(_SEPERATOR);
    return this;
  }

  Future<String> build() async {
    String request = _request.toString();
    if (request.length <= 4) {
      return '';
    } else {
      request = request.substring(0, request.length - 4);
      Log.printLog(request);
      return Crypto.encrypt(request);
    }
  }
}
