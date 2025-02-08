import 'dart:convert';
import 'dart:io';
import 'package:atomshop/common/utils/app_utils.dart';
import 'package:atomshop/local_storage/local_storage_methods.dart';
import 'package:atomshop/network/urls/app_urls.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();
  factory NetworkManager() => _instance;
  NetworkManager._internal();

  final String baseUrl = AppUrls.baseUrl;
  //String? userApiToken = LocalStorageMethods.instance.getUserApiToken();

  Future<dynamic> getRequest(String endpoint, {String? apiToken}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${apiToken ?? LocalStorageMethods.instance.getUserApiToken()}'
      });
      print(response.body);
      return _processResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      AppUtils.hideLoading();
      throw Exception('Unexpected error occurred during GET request: $e');
    }
  }

  Future<dynamic> postRequest(String endpoint, Map<String, dynamic> payload,
      {String? apiToken}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${apiToken ?? LocalStorageMethods.instance.getUserApiToken()}',
        },
        body: jsonEncode(payload),
      );
      //print(response.body);
      return _processResponse(response);
    } on SocketException {
      // AppUtils.hideLoadinDialog();
      throw Exception('No Internet connection');
    } catch (e) {
      // AppUtils.hideLoadinDialog();
      throw Exception('Unexpected error occurred during POST request: $e');
    }
  }

  dynamic _processResponse(http.Response response) {
    var data;
    try {
      data = json.decode(response.body);
    } catch (e) {
      throw Exception('Failed to parse response: $e');
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    } else {
      AppUtils.hideLoading();
      throw Exception(data['message'] ??
          'Error occurred with status: ${response.statusCode}');
    }
  }

  Future<dynamic> delRequest(String endpoint, {String? apiToken}) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl$endpoint'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ${apiToken ?? LocalStorageMethods.instance.getUserApiToken()}'
      });
      print(response.body);
      return _processResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      AppUtils.hideLoading();
      throw Exception('Unexpected error occurred during DEL request: $e');
    }
  }
}
