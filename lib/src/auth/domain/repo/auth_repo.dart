import 'package:tdd_tutorial/core/userdef/typedef.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';

abstract class AuthRepo{
  const AuthRepo();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUser(); 
}