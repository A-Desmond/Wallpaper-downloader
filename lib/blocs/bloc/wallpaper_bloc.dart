import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallper_chnager/data/local_data_source/local_storage.dart';
import '../../data/remote_data_source/wallpaper_api.dart';
import '../../model/photo.dart';


part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  final WallpaperApi wallpaperApi;
  final LocalStorage localStorage;
  WallpaperBloc(this.localStorage, this.wallpaperApi) : super(WallpaperInitial()) {
    on<WallpaperSearch>((event, emit) async {
      emit(WallpaperLoading());
      try {
        localStorage.savelastSearchedWord(keyword: event.query);
        List<Photos> wallpaperlist =
            await wallpaperApi.pictureQuery(query: event.query);
        emit(WallPaperSearchedResult(photos: wallpaperlist));
      } catch (e) {
        emit(WallpaperError(error: e.toString()));
      }
    });
  }
}
