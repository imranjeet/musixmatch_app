import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'BLoC/internet_bloc/internet_bloc.dart';
import 'BLoC/music_cubits.dart';
import 'Screens/trending_screen.dart';
import 'services/api_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetBloc(),
          child: const HomeScreen(),
        ),
        BlocProvider<MusicCubits>(
          create: (context) => MusicCubits(
          )..getData(),
          child: const MainScreen(),
        ),
      ],
      child: MaterialApp(
        title: 'Musixmatch App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: BlocProvider(
          create: (context) => InternetBloc(),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
