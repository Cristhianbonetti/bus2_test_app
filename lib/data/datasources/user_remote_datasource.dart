import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getRandomUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://randomuser.me/api/';

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getRandomUser() async {
    final response = await client.get(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['results'] as List;
      if (results.isNotEmpty) {
        return UserModel.fromJson(results[0] as Map<String, dynamic>);
      } else {
        throw Exception('No user data returned from API');
      }
    } else {
      throw Exception('Failed to fetch user: ${response.statusCode}');
    }
  }
}

