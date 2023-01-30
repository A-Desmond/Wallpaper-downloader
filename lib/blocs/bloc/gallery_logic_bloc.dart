import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallper_chnager/repository/wallpaper_logics.dart';

part 'gallery_logic_event.dart';
part 'gallery_logic_state.dart';

class GalleryLogicBloc extends Bloc<GalleryLogicEvent, GalleryLogicState> {
  final SetWallpaperLogics wallperLogics;
  GalleryLogicBloc(this.wallperLogics) : super(GalleryLogicInitial()) {
    on<DownloadWallpaperEvent>((event, emit) async {
      try {
        await wallperLogics.downloadImage(url: event.url);
        emit(DownloadSuccess());
      } catch (e) {
        emit(DownloadFailure(error: e.toString()));
      }
    });

    on<ApplyWallpaperEvent>((event, emit) async {
      try {
        await wallperLogics.applyWallpaper(url: event.url);
        emit(WallpaperAppliedSuccess());
      } catch (e) {
        WallpaperAppliedFailure(error: e.toString());
      }
    });

    on<ShareWallpaperEvent>((event, emit) async {
      try {
        await wallperLogics.shareImage(url: event.url);
        emit(WallpaperShareSuccess());
      } catch (e) {
        WallpaperShareFailure(error: e.toString());
      }
    });
  }
}
