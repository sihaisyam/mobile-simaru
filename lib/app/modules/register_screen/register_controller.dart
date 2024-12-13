import 'dart:convert';
import 'package:get/get.dart';
import 'package:getx_intro/app/modules/home_page.dart';
import 'package:getx_intro/app/modules/login_screen/login_page.dart';
import 'package:getx_intro/app/modules/register_screen/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var passwordConfirmation = ''.obs;

  void setName(String value) => name.value = value;
  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;
  void setConfirmation(String value) => passwordConfirmation.value = value;

  Future<void> register() async {
    var url = Uri.parse('https://simaru.amisbudi.cloud/api/auth/register');
    http.Response response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name.value,
          'email': email.value,
          'password': password.value,
          'password_confirmation': passwordConfirmation.value,
        }));
    if (response.statusCode == 201) {
      Get.snackbar('Success', "Registrasi berhasil!");
      Get.off(LoginPage()); // Replace with your next page
    } else {
      Get.snackbar('Error', response.body);
    }
  }
}
