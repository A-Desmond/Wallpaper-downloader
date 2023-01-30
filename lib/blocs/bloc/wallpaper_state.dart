part of 'wallpaper_bloc.dart';

abstract class WallpaperState extends Equatable {
  const WallpaperState();

  @override
  List<Object> get props => [];
}

class WallpaperInitial extends WallpaperState {}

class WallPaperSearchedResult extends WallpaperState {
  final List<Photos> photos;

  const WallPaperSearchedResult({required this.photos});

  @override
  List<Object> get props => [photos];
}

class WallpaperLoading extends WallpaperState {}

class WallpaperError extends WallpaperState {
  final Object error;

  const WallpaperError({required this.error});

  @override
  List<Object> get props => [error];
}
