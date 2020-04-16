import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:sfscredit/ui/views/auth/login_screen.dart';

import '../locator.dart';
import 'dialog_service.dart';
import 'navigation_service.dart';
import 'token_service.dart';

class NetworkService {
  final TokenService _tokenService = locator<TokenService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future<http.Response> get(
    String url, {
    Map<String, String> headers,
    bool isAuth = false,
  }) async {
    final String token = _tokenService.getToken();
    final http.Response res = await http.get(url, headers: <String, String>{
      if (isAuth) HttpHeaders.authorizationHeader: 'Bearer $token',
      ...headers
    });
    if (res.statusCode == 401) {
      _dialogService.showDialog(title: "Session Expired", description: "Please Login");
      _navigationService.navigateAndClearRoute(LoginScreen.routeName);
//      final String tokenStr = await refresh(token);
//      return await http.get(url, headers: <String, String>{
//        if (isAuth) HttpHeaders.authorizationHeader: 'Bearer $tokenStr',
//        ...headers
//      });
    }
    return res;
  }

  Future<http.Response> post(
    String url, {
    Map<String, String> headers,
    dynamic body,
    bool isAuth = false,
    bool encodeBody = true,
  }) async {
    final String token = _tokenService.getToken();
    final jsonBody = encodeBody ? jsonEncode(body) : body;
    final http.Response res = await http.post(
      url,
      headers: <String, String>{
        if (isAuth) HttpHeaders.authorizationHeader: 'Bearer $token',
        ...headers
      },
      body: jsonBody,
    );
    if (res.statusCode == 401) {
      final String tokenStr = await refresh(token);
      return await http.post(
        url,
        headers: <String, String>{
          if (isAuth) HttpHeaders.authorizationHeader: 'Bearer $tokenStr',
          ...headers
        },
        body: jsonBody,
      );
    }
    return res;
  }

  Future<http.Response> put(
    String url, {
    Map<String, String> headers,
    dynamic body,
    bool isAuth = false,
    bool encodeBody = true,
  }) async {
    final String token = _tokenService.getToken();
    final jsonBody = encodeBody ? jsonEncode(body) : body;
    final http.Response res = await http.put(
      url,
      headers: <String, String>{
        if (isAuth) HttpHeaders.authorizationHeader: 'Bearer $token',
        ...headers
      },
      body: jsonBody,
    );
    if (res.statusCode == 401) {
      final String tokenStr = await refresh(token);
      return await http.put(
        url,
        headers: <String, String>{
          if (isAuth) HttpHeaders.authorizationHeader: 'Bearer $tokenStr',
          ...headers
        },
        body: jsonBody,
      );
    }
    return res;
  }

  Future<http.Response> postFile(String url,
      {Map body}) async {
    final String token = _tokenService.getToken();
    var uri = Uri.parse(url);
    var fileKey = body.keys.firstWhere((fieldKey) => body[fieldKey].runtimeType.toString().contains('File'), orElse: () => null);
    print("FileKey: $fileKey");
    if(fileKey == null){
      throw new Exception("File is required");
    }
    File imageFile = body[fileKey];
    var stream = new http.ByteStream(Stream.castFrom(imageFile.openRead()));
    var length = await imageFile.length();
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = 'Bearer $token';
    http.MultipartFile multipartFile =
        new http.MultipartFile(fileKey, stream, length);
    request.files.add(multipartFile);
    http.StreamedResponse streamRes = await request.send();
    return http.Response.fromStream(streamRes);
  }

  Future<String> refresh(String token) async {
    final http.Response res = await post(
      'auth/refresh',
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
      },
      body: jsonEncode({}),
    );
    if (res.statusCode == 200) {
      final Map<String, dynamic> jsonRes = jsonDecode(res.body);
      final String accessToken = jsonRes['access_token'];
      _tokenService.token = jsonRes;
      return accessToken;
    }
    //return null;
  }
}
