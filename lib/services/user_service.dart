import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  //Pick an Image from the Gallery or Camera
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  //Save the ImagePath to SharedPreference
  Future<void> saveImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("profile_image", imagePath);
  }

  //Get the Save ImagePath
  Future<String?> getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("profile_image");
  }

  //User Data
  static const String _keyName = "user_name";
  static const String _keyEducation = "user_education";
  static const String _keyAge = "user_age";
  static const String _keyEmail = "user_Email";

  //Save User Data
  static Future<void> saveUserData(
    String name,
    String education,
    int age,
    String email,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_name", name);
    await prefs.setString("user_education", education);
    await prefs.setInt("user_age", age);
    await prefs.setString("user_Email", email);
  }

  //Get User Data
  static Future<Map<String, dynamic>> getUserData() async{
    final prefs = await SharedPreferences.getInstance();
    return{
      "name": prefs.getString(_keyName) ?? "",
      "education": prefs.getString(_keyEducation) ?? "",
      "age": prefs.getInt(_keyAge) ?? 0,
      "email": prefs.getString(_keyEmail) ?? 0,
    };
  }

  //Clear User Data
  static Future<void> clearUserData() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
