import 'package:tdd_tutorial/core/usecase/usecase.dart';
import 'package:tdd_tutorial/core/userdef/typedef.dart';
import 'package:tdd_tutorial/src/auth/domain/repo/auth_repo.dart';

import '../entities/user.dart';

class GetUsers extends UseCaseWithoutParams<List<User>> {
  final AuthRepo repository;

  GetUsers(this.repository);

  @override
  ResultFuture<List<User>> call() async=>repository.getUser();
}