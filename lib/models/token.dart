class Token {
  String token = '';
  String expiracion = '';

  Token({required this.token, required this.expiracion});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiracion = json['expiracion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expiracion'] = this.expiracion;
    return data;
  }
}
