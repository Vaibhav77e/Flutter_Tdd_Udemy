// import 'dart:convert';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mocktail/mocktail.dart';
// import 'package:tdd_tutorial/core/constants/constants.dart';
// import 'package:tdd_tutorial/src/auth/data/datasources/auth_remote_data_sourecs.dart';

// class MockAuthenticationRemoteSourceImpl extends Mock implements http.Client {}

// void main() {
//   late http.Client mockClient;
//   late AuthenticationRemoteSource mockRemoteSource;

//   setUp(() {
//     mockClient = MockAuthenticationRemoteSourceImpl();
//     mockRemoteSource = AuthenticationRemoteSourceImpl(mockClient);
//     registerFallbackValue(Uri());
//   });

//   group(
//     'create User',
//     () async {
//       test(
//         'should complete creating user and then return 200 or 201 response',
//         () async {
//           when(() async {
//             mockClient.post(any(), body: any(named: 'body'));
//           }
//           ).thenAnswer((_) => http.Response('User created successfully', 201)); 

//           final methodCall = await mockRemoteSource.createUser;

//           expect(
//               () => methodCall(
//                   createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
//               completes);

//           verify(
//             () => mockClient.post(
//               Uri.parse('$kBaseUrl$createNewUserEndpoint'),
//               body: jsonEncode(
//                 {'createdAt': 'createdAt', 'name': 'name', 'avatar': 'avatar'},
//               ),
//             ),
//           ).called(1);

//           verifyNoMoreInteractions(AuthenticationRemoteSource);

//         },
//       );


//     },
//   );
// }



import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/core/constants/constants.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/src/auth/data/datasources/auth_remote_data_sourecs.dart';
import 'package:tdd_tutorial/src/auth/data/model/user_model.dart';


class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteSourceImpl(client);
    registerFallbackValue(Uri.parse(''));
  });

  group('createUser', () {
    test('should complete successfully when the status code is 200 or 201',
      () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
              (_) async => http.Response('User created successfully', 200),
      );

      final methodCall = remoteDataSource.createUser;

      expect(
        methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        completes);

      verify(() => client.post(Uri.https(kBaseUrl, getUserEndpoint),
      body: jsonEncode({
        'createdAt': 'createdAt',
        'name': 'name',
        'avatar': 'avatar',
      }),
      ),
      ).called(1);

      verifyNoMoreInteractions(client);
      },
    );

    test('Should throw an exception when there is ApiException',()async{

      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
              (_) async => http.Response('Invalid Email address', 400),
      );

      final methodCall = remoteDataSource.createUser;

      expect(() => methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),throwsA(ServerExceptions(message: 'Invalid Email address', statusCode: 400)));

      verify(() => client.post(Uri.https(kBaseUrl, getUserEndpoint),
      body: jsonEncode({
        'createdAt': 'createdAt',
        'name': 'name',
        'avatar': 'avatar',
      }),
      ),
      ).called(1);

      verifyNoMoreInteractions(client);

    });
  });

   group('getUser', () {
    final tUsers = [UserModel.empty()];
    test(
      'should return [List<User>] when the status code is 200',
          () async {
        when(() => client.get(any())).thenAnswer(
              (_) async =>
              http.Response(jsonEncode([tUsers.first.toMap()]), 200),
        );

        final result = await remoteDataSource.getUser();

        expect(result, equals(tUsers));

        verify(() => client.get(Uri.https(kBaseUrl, getUserEndpoint)))
            .called(1);
        verifyNoMoreInteractions(client);
      },
    );


    test(
      'should return ServerExceptions when the status code is not 200',
        () async {
        final tMessage = 'Server illa bsdk, Server illa baka';

        when(()async=>client.get(any())).thenAnswer((_) async=> http.Response(tMessage,500));

        final result =  remoteDataSource.getUser();

        print(result);

        expect(()=>result, throwsA(ServerExceptions(message: tMessage,statusCode:500)));
        
        verify(() => client.get(Uri.https(kBaseUrl, getUserEndpoint)))
            .called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}