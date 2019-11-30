import 'enum.dart';

class BuildEnvironment<String> extends Enum<String> {
  
    const BuildEnvironment(String val) : super (val);

    static const PRODUCTION = const BuildEnvironment('https://halil.epaisa.com');
    static const STAGING = const BuildEnvironment('https://development.epaisa.com');
    static const DEVELOPMENT = const BuildEnvironment('https://nine.epaisa.com');
   }