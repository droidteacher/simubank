import 'package:equatable/equatable.dart';
import 'package:mt_assignment/data/remote/user_datasource.dart';

abstract class LoginState extends Equatable {}

class NotFilledIn extends LoginState {
  @override
  List<Object?> get props => [];
}

class Processing extends LoginState {
  @override
  List<Object?> get props => [];

}

class LoginSuccess extends LoginState {
  final SBUser user;

  LoginSuccess({required this.user});
  
  @override
  List<Object?> get props => [user];
}

class LoginFailed extends LoginState {
  @override
  List<Object?> get props => [];
}

class MissingCredentials extends LoginState {
  @override
  List<Object?> get props => [];
}

class CanRegister extends LoginState {
  @override
  List<Object?> get props => [];
}

