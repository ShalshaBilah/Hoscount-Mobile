// bloc/forgot_password_event.dart
abstract class ForgotPasswordEvent {}

class ForgotPasswordRequested extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordRequested(this.email);
}
