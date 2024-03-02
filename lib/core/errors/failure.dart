import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';

// ignore: must_be_immutable
abstract class Failure extends Equatable{
 String message;
 int statusCode;

 Failure({
  required this.message,
  required this.statusCode
 });

 String get failureMessage => '$message''Error : $message';

 @override
   List<Object?> get props =>[message,statusCode];


}

class ApiFailure extends Failure{
  ApiFailure({required super.message,required super.statusCode});

  ApiFailure.fromException(ServerExceptions apiException) : this(message: apiException.message, statusCode: apiException.statusCode);
}