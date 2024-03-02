import 'dart:convert';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';


class UserModel extends User{
  UserModel({
    required super.avatar,
    required super.createdAt,
    required super.name,
    required super.id
  });

  factory UserModel.fromJson(String source)=>UserModel.fromMap(jsonDecode(source) as Map<String,dynamic>);

  UserModel.fromMap(Map<String,dynamic> map):this(
  avatar:map['avatar'] as String,
  createdAt:map['createdAt'] as String,
  name:map['name'] as String,
  id:map['id'] as String);

  UserModel.empty():this(
  id: "1",
  createdAt: "_empty.createdAt",
  name:"_empty.name",
  avatar:"_empty.avatar");

  UserModel copyWith({
    String? name,
    String? avatar,
    String? id,
    String? createdAt,

  }){
    return UserModel(
    avatar: avatar??this.avatar, 
    createdAt: createdAt??this.createdAt, 
    name: name??this.name, 
    id: id??this.id);
  }

  Map<String,dynamic> toMap() =>{
    'id':id,
    'avatar':avatar,
    'createdAt':createdAt,
    'name':name,
  };
  String toJson()=>jsonEncode(toMap());

  
}

void main(){
  final user = UserModel.empty();
  final newUser = user.copyWith(name: 'whatever i don\'t understood a single thing');
  
}