import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/src/bloc/genres_bloc.dart';
import 'package:movies_app/src/models/genre_model.dart';

void main() async {
  GenresBloc _genresBloc;

  setUp((){
    _genresBloc = GenresBloc();
  });

  group('BloC testing', (){
    test('Genres BloC testing fetchAllGenres', () async {
      _genresBloc.fetchAllGenres();
      _genresBloc.allGenres.listen(expectAsync1((value){
        expect(value, isInstanceOf<GenreModel>());
      }));
    });
  });
}
