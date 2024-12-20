import 'dart:convert';
import 'package:get/get.dart';
import 'package:getx_intro/app/modules/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var user = ''.obs;

  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;

 Future<void> login() async {

  var url = Uri.parse('https://simaru.amisbudi.cloud/api/auth/login');
  http.Response response = await http.post(url,
  headers: {'Content-Type': 'application/json'},
  body:jsonEncode( 
  {
    'email': email.value,
    'password': password.value,
  })
  );
  print('Response body: ${response.body}');
  var userData = jsonDecode(response.body);

    // Implement your login logic here
    // For demonstration, we'll just check if the fields are not empty
    if (response.statusCode == 200) {
      // Save the email to local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(userData));

      // Navigate to another page
      Get.off(HomePage()); // Replace with your next page
    } else {
      Get.snackbar('Error', response.body);
    }
  }

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.value = prefs.getString('user') ?? '';
  }
}
