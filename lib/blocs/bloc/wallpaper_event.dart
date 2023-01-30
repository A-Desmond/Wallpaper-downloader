part of 'wallpaper_bloc.dart';

abstract class WallpaperEvent extends Equatable {
  const WallpaperEvent();

  @override
  List<Object> get props => [];
}

class WallpaperSearch extends WallpaperEvent {
  final String query;
 const  WallpaperSearch({required this.query});
  @override
  List<Object> get props => [query];
}
