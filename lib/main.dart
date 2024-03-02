import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/core/services/injection_container.dart';
import 'package:tdd_tutorial/src/auth/presentation/cubit/authenication_cubit.dart';

import 'src/auth/presentation/bloc/auth_bloc.dart';
import 'src/auth/presentation/views/home/homescreen.dart';

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthenticationCubit>(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
          ),
          home: HomeScreen()),
    );
  }
}
