import 'package:bloc_project/data/data_source/movie_api_service.dart';
import 'package:bloc_project/domain/repository/movie_repository.dart';
import 'package:bloc_project/screen/movie_list/home_screen.dart';
import 'package:bloc_project/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async  {
  await initializeDateFormatting('uk_UA', null);
  initDi();
  runApp(const MyApp());
}

void initDi() {
  GetIt.instance.registerSingleton<MovieApiService>(MovieApiService());
  GetIt.instance.registerSingleton<MovieRepository>(MovieRepository());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const HomeScreen(),
    );
  }
}
