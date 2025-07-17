import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia/features/palindrome/presentation/pages/first_screen.dart';
import 'package:suitmedia/features/user/presentation/bloc/user/remote/remote_user_bloc.dart';
import 'package:suitmedia/features/user/presentation/bloc/user/remote/remote_user_event.dart';
import 'injection_container.dart';
import 'config/theme/app_theme.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteUserBloc>(
      create: (context) => sl()..add(const GetUsers()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Suitmedia',
        theme: theme(),
        home: FirstScreen()
      ),
    );
  }
}
