part of 'gallery_logic_bloc.dart';

abstract class GalleryLogicEvent extends Equatable {
  const GalleryLogicEvent();
  @override
  List<Object> get props => [];
}

class DownloadWallpaperEvent extends GalleryLogicEvent {
  final String url;
  const DownloadWallpaperEvent({required this.url});
  @override
  List<Object> get props => [url];
}

class ApplyWallpaperEvent extends GalleryLogicEvent {
  final String url;
  const ApplyWallpaperEvent({required this.url});
  @override
  List<Object> get props => [url];
}

class ShareWallpaperEvent extends GalleryLogicEvent {
  final String url;
  const ShareWallpaperEvent({required this.url});
  @override
  List<Object> get props => [url];
}
