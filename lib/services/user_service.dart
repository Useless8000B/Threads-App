import 'package:http/http.dart' as http;
import 'package:threads_app/services/auth_service.dart';

class UserService {
  static const String _baseUrl = String.fromEnvironment("API_URL");
  final AuthService _authService = AuthService();

  Future<bool> updateProfilePicture(String filePath) async {
    try {
      final token = await _authService.token;
      if (token == null) return false;

      var request = http.MultipartRequest('POST', Uri.parse("$_baseUrl/upload-photo"));

      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        filePath,
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}