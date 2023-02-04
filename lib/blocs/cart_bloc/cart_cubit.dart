import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/models/movie_model.dart';

class CartBloc extends Cubit<List<Movie>> {
  CartBloc() : super([]);

  void addQtyFunc(Movie movie) {
    List<Movie> list = [];
    for (var each in state) {
      list.add(Movie.cloneCart(each));
    }
    list.add(movie);
    emit(list);
  }

  void deleteFromCart(Movie movie) {
    List<Movie> list = List.of(state);
    list.removeWhere((element) => element.id == movie.id);
    emit(list);
  }
}
