enum LoginDataType {
  userName('/UserName'),
  userEmail('/UserEmail'),
  userPhone('/UserPhone'),
  userPassWord('/UserPassWord');

final String loginType;
const LoginDataType(this.loginType);
}