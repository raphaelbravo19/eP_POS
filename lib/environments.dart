class Env {
  String server;
  String clientId;
  String clientIv;
  String clientSecret;
  int sourceId;
  Env({
    this.server,
    this.clientId,
    this.clientIv,
    this.clientSecret,
    this.sourceId,
  });
}

class Environment {
  static Env staging = Env(
    server: 'https://development.epaisa.com',
    clientId: 'VyBqmaWHtyrbRSMzmbgbOy2I',
    clientIv: 'VyBqmaWH',
    clientSecret: '0V7BpWR5r2Zy58ZRkHxeTKLn',
    sourceId: 8,
  );
  static Env production = Env(
    server: 'https://halil.epaisa.com',
    clientId: '8fqCoX0RlPEFrd9EjacNmiKG',
    clientIv: '8fqCoX0R',
    clientSecret: 'ai3FaHi18bOonCTkgZao71Ur',
    sourceId: 2,
  );
  static Env uat = Env(
    server: 'https://nine.epaisa.com',
    clientId: 'I0TWr2VmzSuyDjLocEqUlnhk',
    clientIv: 'I0TWr2Vm',
    clientSecret: 'QrYckeIBHL4NEHZo9iUSjtls',
    sourceId: 2,
  );
}

Env current = Environment.staging;
