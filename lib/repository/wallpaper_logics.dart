import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SetWallpaperLogics {
  Future<void> applyWallpaper({required String url}) {
    return AsyncWallpaper.setWallpaper(
      url: url,
      wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
    ).then((value) => SystemNavigator.pop());
  }

  Future<bool?> downloadImage({required String url}) async {
    return await GallerySaver.saveImage(url, toDcim: true);
  }

  shareImage({required String url}) async {
    final response = await http.get(Uri.parse(url));
    Directory tempDir = await getTemporaryDirectory();
    String imagePath = tempDir.path;
    final file = File('$imagePath.png');
    final imageFile = await file.writeAsBytes(response.bodyBytes);
    await Share.shareXFiles([XFile(imageFile.path)], text: 'Wallpaper chnager');
  }
}
