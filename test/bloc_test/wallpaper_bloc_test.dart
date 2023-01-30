import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wallper_chnager/blocs/bloc/wallpaper_bloc.dart';
import 'package:wallper_chnager/data/local_data_source/local_storage.dart';
import 'package:wallper_chnager/data/remote_data_source/wallpaper_api.dart';
import 'package:wallper_chnager/model/photo.dart';

class WallPaperApiMock extends Mock implements WallpaperApi {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('wallpaper bloc test', () {
    late WallpaperBloc wallpaperBloc;
    late LocalStorage storage;
    late WallpaperApi wallpaperApi;
    late WallPaperApiMock wallPaperApiMock;

    setUp(() {
      storage = LocalStorage();
      wallpaperApi = WallpaperApi();
      wallPaperApiMock = WallPaperApiMock();
      wallpaperBloc = WallpaperBloc(storage, wallpaperApi);
    });

    List<Photos> photo = [Photos(portrait: 'portrait', medium: 'medium')];
    test('Initial state', () {
      expect(wallpaperBloc.state, WallpaperInitial());
    });

/// test under development
    blocTest<WallpaperBloc, WallpaperState>(
        'emits [MyState] when MyEvent is added.',
        build: () {
          when(wallPaperApiMock.pictureQuery(query: 'hello'))
              .thenAnswer((realInvocation) async {
            return photo;
          });
          return wallpaperBloc;
        },
        act: (bloc) => bloc.add(const WallpaperSearch(query: 'hello')),
        expect: () async {
          WallPaperSearchedResult(
              photos: [Photos(portrait: 'portrait', medium: 'medium')]);
        });
  });
}
