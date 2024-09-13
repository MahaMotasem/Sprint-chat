abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupFailed extends SignupState {
  final String errorMessage;

  SignupFailed({required this.errorMessage});
}

class SignupSuccess extends SignupState {
  final String message;

  SignupSuccess({required this.message});
}
