
import 'dart:convert';


import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_tutorial/src/auth/data/model/user_model.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main(){

  final tModel = UserModel.empty();

  test('should be a subclass of [User] entity', (){
    // Assert
    expect(tModel,isA<User>());

  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson);

  group('fromMap', () {
  test('should return a [UserModel] with right data ', (){
    final result =  UserModel.fromMap(tMap);
    expect(result, equals(tModel));
    });
  });

  group("fromJson", (){
    test('should return a [UserModel] with right data ', (){
    final result =  UserModel.fromJson(tJson);
    expect(result, equals(tModel));
    });
  }
  );

  group("toMap", () { 
   test('should return a [UserModel] with right data ', (){
      //Act
      final result = tModel.toMap();

      //assert
      expect(result,equals(tMap));
    });
  });

  group('toJson', () {
     test('should return a [JSON]  string with right data ', (){
      //Act
      final result = tModel.toJson();

      //assert
      expect(result,equals(tJson));
    });

  });

  group('copy with',(){
    test('should return a [UserModel] with different data ', (){
     
     final result = tModel.copyWith(name:'Stupid course');

     expect(result.name, equals('Stupid course'));
    });
  });


}