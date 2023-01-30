import 'dart:convert';

import 'package:wallper_chnager/model/photo.dart';
import 'package:http/http.dart' as http;

class WallpaperApi {
  Future<List<Photos>> pictureQuery({
    required String query,
  }) async {
    List<Photos> wallpapers = [];
    Uri url =
        Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=80');
    Map<String, String> header = {
      'Authorization':'jWrDer5Mn5o4uWDFOmFVPS02qqMtqHGbTUbCAhha1W2TxmioE2RUINDD',
    };
    var request = await http.get(url, headers: header);
    if (request.statusCode == 200) {
      wallpapers.clear();
      var result = json.decode(request.body);
      result['photos'].forEach((photo) {
        wallpapers.add(Photos.fromJson(photo));
      });
    }
    return wallpapers;
  }
}
