import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/usecase/usecase.dart';
import 'package:tdd_tutorial/core/userdef/typedef.dart';
import 'package:tdd_tutorial/src/auth/domain/repo/auth_repo.dart';

class CreateUser extends UseCaseWithParams<void ,CreateUserParams> {
  final AuthRepo _authRepo;
  CreateUser(this._authRepo);
  
  @override
  ResultVoid call(params) async=>
  _authRepo.createUser(createdAt: params.createdAt, name: params.name, avatar: params.avatar);

}

class CreateUserParams extends Equatable{
  final String name;
  final String createdAt;
  final String avatar;

  CreateUserParams.empty():this(avatar: '_empty.avatar', name: '_empty.name', createdAt:'_empty.createdAt');

  CreateUserParams({required this.name, required this.avatar, required this.createdAt});


  @override
  // TODO: implement props
  List<Object?> get props => [name, createdAt, avatar];
  
}
