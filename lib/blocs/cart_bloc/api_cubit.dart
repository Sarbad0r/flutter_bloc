import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/api/api_conn.dart';
import 'package:flutter_bloc_learning/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiCubitPriceList extends Cubit<List<Movie>> {
  ApiCubitPriceList() : super([]);

  //image : https://image.tmdb.org/t/p/w500/

  void callFromApi() async {
    var res = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/popular?api_key=881c7aff9ede080330ddc2616bca1374&language=en-US&page=1'),
        headers: await ApiConnections.headers());
    if (res.statusCode == 200) {
      List<Movie> movieList = [];
      Map<String, dynamic> map = jsonDecode(res.body);
      List<dynamic> list = map['results'];
      for (var each in list) {
        movieList.add(Movie.fromJson(each));
      }
      state.addAll(movieList);
      emit(state);
    }
  }
}
