import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/blocs/main_bloc.dart';
import 'package:flutter_bloc_learning/pages/home_page.dart';
import 'package:sizer/sizer.dart';

void main() {
  Bloc.observer = MainBloc(); //можно посмотреть что изменяется ф приложении (not requared)
  runApp(Sizer(
      builder: (context, orientation, deviceType) =>
          MaterialApp(debugShowCheckedModeBanner: false, home: HomePage())));
}
