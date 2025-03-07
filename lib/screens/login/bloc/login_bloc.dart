import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mt_assignment/data/remote/user_datasource.dart';
import 'package:mt_assignment/screens/login/bloc/login_event.dart';
import 'package:mt_assignment/screens/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserDatasource userDatasource;

  String? _userInputEmail;
  String? _userInputPassword;

  LoginBloc({required this.userDatasource}) : super(NotFilledIn()) {
    on<ClickLogin>(_onClickLogin);
    on<ClickRegistration>(_onClickRegistration);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  void _onClickLogin(ClickLogin event, Emitter<LoginState> emit) async {
    emit(Processing());

    if (_userInputEmail != null && _userInputPassword != null) {
      try {
        SBUser? loggedInUser =
            await userDatasource.login(_userInputEmail!, _userInputPassword!);
        if (loggedInUser != null) {
          emit(LoginSuccess(user: loggedInUser));
        }
      } on BadCredentialsException {
        emit(LoginFailed());
      }
    } else {
      emit(MissingCredentials());
    }
  }

  void _onClickRegistration(ClickRegistration event, Emitter<LoginState> emit) {
    emit(CanRegister());
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    _userInputEmail = event.userInput;
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    _userInputPassword = event.userInput;
  }
}
