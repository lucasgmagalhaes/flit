import 'package:flit/flit.dart';

part 'user.g.dart';

@Table()
class User {
  int id;
  @Column(name: "user_name")
  String name; 
  @Column(name: "email_usuario")
  String email;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}