abstract class LoginEvent {}

class ClickLogin extends LoginEvent {}

class ClickRegistration extends LoginEvent {}

class EmailChanged extends LoginEvent {
  final String userInput;

  EmailChanged({required this.userInput});
}

class PasswordChanged extends LoginEvent {
  final String userInput;

  PasswordChanged({required this.userInput});
}



