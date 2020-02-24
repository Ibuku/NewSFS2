class TokenService {
  String _token = "hello";
  getToken(){
    return _token;
  }

  setToken(String token){
    _token = token;
  }
}