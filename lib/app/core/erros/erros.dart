class Failure implements Exception {
  final String? message;

  Failure({this.message});

  @override
  String toString() {
    String? msg = message;
    return msg?.trim().replaceAll("Exception: ", "") ?? "Erro";
  }
}


class DataSourceEmpty extends Failure {
  @override
  final String? message;

  DataSourceEmpty({this.message = 'Sem dados'}): super(message: message);

}

class DataSourceException extends Failure {
  @override
  final String? message;

  DataSourceException({this.message = 'Erro na consulta'}): super(message: message);

}

class InvalidParamets extends Failure {
  @override
  final String? message;

  InvalidParamets({this.message = 'Parâmetros inválidos'}) : super(message: message);
}

class DataSourceNull extends Failure {
  DataSourceNull({super.message = "Não foram encontrados registros"});
}


class ErrorLoginUserName extends Failure{
  @override
  final String? message;

  ErrorLoginUserName({this.message = 'Username ou senha inválida'}) : super(message: message);
}

class StorageFailure extends Failure {
  @override
  final String? message;
  StorageFailure({this.message = 'Error ao gravar dados'}) : super(message: message);
}

class ErrorGetLoggedUser extends Failure {
  @override
  final String? message;
  ErrorGetLoggedUser({this.message}) : super(message: message);
}