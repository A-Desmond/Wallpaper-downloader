part of 'gallery_logic_bloc.dart';

abstract class GalleryLogicState extends Equatable {
  const GalleryLogicState();

  @override
  List<Object> get props => [];
}

class GalleryLogicInitial extends GalleryLogicState {}

// Save to gallery
class DownloadSuccess extends GalleryLogicState {}

class DownloadFailure extends GalleryLogicState {
  final Object error;

  const DownloadFailure({required this.error});

  @override
  List<Object> get props => [];
}

///change wallpaper

class WallpaperAppliedSuccess extends GalleryLogicState {}

class WallpaperAppliedFailure extends GalleryLogicState {
  final Object error;

  const WallpaperAppliedFailure({required this.error});

  @override
  List<Object> get props => [error];
}

//share wallpaper
class WallpaperShareSuccess extends GalleryLogicState {}

class WallpaperShareFailure extends GalleryLogicState {
  final Object error;

  const WallpaperShareFailure({required this.error});

  @override
  List<Object> get props => [error];
}
