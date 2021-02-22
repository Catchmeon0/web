import 'package:flutter_test/flutter_test.dart';
import 'package:web/screens/login/signupForm.dart';

void main() {

  test('Empty Email Test', () {
    var result = FieldValidator.validateEmail('');
    expect(result, 'Please Enter Email');
  });

  test('Invalid Email Test', () {
    var result = FieldValidator.validateEmail('invalidEmail');
    expect(result, 'Enter Valid Email');
  });

  test('Valid Email Test', () {
    var result = FieldValidator.validateEmail('ValidEmail@valid.com');
    expect(result,null);
  });

 test('InValid username size less then 6 characters  Test', () {
    var result = FieldValidator.validateUsername('az');
    expect(result,"Name must be more than 3 characters");
  });

 test('Valid username Test', () {
    var result = FieldValidator.validateUsername('azerty');
    expect(result,null);
  });

 test('Empty Password Test', () {
    var result = FieldValidator.validatePassword('');
    expect(result,"Please Enter password");
  });

  test('InValid Password  size less then 6 characters  Test', () {
    var result = FieldValidator.validatePassword('a3z');
    expect(result,"password must contain at least 6 characters");
  });

  test('Valid Password  Test', () {
    var result = FieldValidator.validatePassword('a3zaze');
    expect(result,null);
  });


  test('Empty PasswordConfirmation  Test', () {
    var result = FieldValidator.validatePasswordConfirma('', 'a3zaze', '');
    expect(result,"Please confirm password");
  });

  test('Invalid PasswordConfirmation  Test', () {
    var result = FieldValidator.validatePasswordConfirma('confirmpassword', 'password', 'confirmpassword');
    expect(result,"Password do not match");
  });

    test('Valid PasswordConfirmation  Test', () {
    var result = FieldValidator.validatePasswordConfirma('password', 'password', 'password');
    expect(result,null);
  });

}
