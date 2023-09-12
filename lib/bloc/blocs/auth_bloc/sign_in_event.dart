abstract class SignInEvent{}
class SignInTextChangedEvent extends SignInEvent{
  final String email,password;
  SignInTextChangedEvent(this.email,this.password);
}
class SignInSubmittedEvent extends SignInEvent{
  final String email,password;
  SignInSubmittedEvent(this.email,this.password);
}