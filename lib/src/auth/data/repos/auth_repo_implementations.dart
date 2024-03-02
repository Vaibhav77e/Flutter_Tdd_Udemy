
import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/userdef/typedef.dart';
import 'package:tdd_tutorial/src/auth/data/datasources/auth_remote_data_sourecs.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';
import 'package:tdd_tutorial/src/auth/domain/repo/auth_repo.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';

 class AuthenticationRepositoryImplementation implements AuthRepo{

  // dependency injection
  final AuthenticationRemoteSource _remoteDataSource;
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  @override
  ResultVoid createUser({
  required String createdAt,
  required String name,
  required String avatar})async{
    // final dataSources = AuthenticationRemoteSource();

    try{
      await _remoteDataSource.createUser(createdAt:createdAt, name:name, avatar:avatar);
      return Right(null);
    } on ServerExceptions catch(e){
      return Left(ApiFailure.fromException(e));
    }
   }
  
  @override
  ResultFuture<List<User>> getUser()async{
    try{
      final result = await _remoteDataSource.getUser();
      return Right(result);
    } on ServerExceptions catch(e){
       return Left(ApiFailure.fromException(e));
    }

  }
}


