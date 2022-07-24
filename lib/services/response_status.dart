import '../model/user_model.dart';

class Success {
  Object response ;
  Success({required this.response});
}

class Empty {
  Object response ;
  Empty({required this.response});
}

class Failure {
  Object errorResponse;
  Failure({required this.errorResponse});
}

class NetworkError {
  Object errorResponse;
  NetworkError({required this.errorResponse});
}

class AuthFailed {
  Object response ;
  AuthFailed({required this.response});
}

class AuthSuccess {
  Object response ;
  Object? user;
  UserClient? userDetails;
  AuthSuccess({required this.response,this.user,this.userDetails});
}