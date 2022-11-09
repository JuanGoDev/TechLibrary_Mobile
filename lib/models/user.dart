// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class User {
  String id = '';
  String userName = '';
  String normalizedUserName = '';
  String normalizedEmail = '';
  bool emailConfirmed = false;
  String passwordHash = '';
  String securityStamp = '';
  String concurrencyStamp = '';
  String phoneNumber = '';
  bool phoneNumberConfirmed = false;
  bool twoFactorEnabled = false;
  String lockoutEnd = '';
  bool lockoutEnabled = true;
  int accessFailedCount = 0;
  String email = '';
  String password = '';
  String nombre = '';
  String apellido = '';
  int telefono = 0;
  String direccion = '';

  User(
      {required this.id,
      required this.userName,
      required this.normalizedUserName,
      required this.normalizedEmail,
      required this.emailConfirmed,
      required this.passwordHash,
      required this.securityStamp,
      required this.concurrencyStamp,
      required this.phoneNumber,
      required this.phoneNumberConfirmed,
      required this.twoFactorEnabled,
      required this.lockoutEnd,
      required this.lockoutEnabled,
      required this.accessFailedCount,
      required this.email,
      required this.password,
      required this.nombre,
      required this.apellido,
      required this.telefono,
      required this.direccion});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    normalizedUserName = json['normalizedUserName'];
    normalizedEmail = json['normalizedEmail'];
    emailConfirmed = json['emailConfirmed'];
    passwordHash = json['passwordHash'];
    securityStamp = json['securityStamp'];
    concurrencyStamp = json['concurrencyStamp'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    twoFactorEnabled = json['twoFactorEnabled'];
    lockoutEnd = json['lockoutEnd'];
    lockoutEnabled = json['lockoutEnabled'];
    accessFailedCount = json['accessFailedCount'];
    email = json['email'];
    password = json['password'];
    nombre = json['nombre'];
    apellido = json['apellido'];
    telefono = json['telefono'];
    direccion = json['direccion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['normalizedUserName'] = this.normalizedUserName;
    data['normalizedEmail'] = this.normalizedEmail;
    data['emailConfirmed'] = this.emailConfirmed;
    data['passwordHash'] = this.passwordHash;
    data['securityStamp'] = this.securityStamp;
    data['concurrencyStamp'] = this.concurrencyStamp;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['lockoutEnd'] = this.lockoutEnd;
    data['lockoutEnabled'] = this.lockoutEnabled;
    data['accessFailedCount'] = this.accessFailedCount;
    data['email'] = this.email;
    data['password'] = this.password;
    data['nombre'] = this.nombre;
    data['apellido'] = this.apellido;
    data['telefono'] = this.telefono;
    data['direccion'] = this.direccion;
    return data;
  }
}
