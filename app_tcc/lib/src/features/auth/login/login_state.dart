import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum LoginStateStatus{
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  final LoginStateStatus status;
  final String? errorMessage;

  LoginState.initial() : this(status: LoginStateStatus.initial);

  LoginState({
    required this.status,
    this.errorMessage,
  });

  /// CopyWith:
  /// Retorna sempre a instancia e que ele esta, onde dentro dessa instancia serão recebidos todos os atributos que tem como opcionais
  /// 

  LoginState copyWith({
    LoginStateStatus? status,
    ValueGetter<String?>? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      //errorMessage: errorMessage ?? this.errorMessage,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}

