
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';

class ServerExceptions extends Equatable implements Exception{
  String message;
  int statusCode;

  ServerExceptions({required this.message,required this.statusCode});
  @override
  
  List<Object?> get props =>[message,statusCode];
  
}
