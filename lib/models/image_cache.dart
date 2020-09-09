import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:io';

class ImageCache {
  static Future<String> loadImage(String url) async {
    final imageUrl = _prepareUrl(url);
    final uniqId = extractUniqImageId(imageUrl);
    if (uniqId == null || uniqId.isEmpty) {
      return Future.value(uniqId);
    }

    // check in cache
    String cachedFile = await _tryLoadFromCache(uniqId);
    if (cachedFile != null) {
      print('[*] Image loaded from cache: $uniqId');
      return Future.value(cachedFile);
    }

    // load from network if it does not exist
    //print('Loading $imageUrl');
    String loadedFile = await _downloadAndStoreImage(imageUrl);
    if (loadedFile != null && loadedFile.isNotEmpty) {
      print('[~] Image loaded from network: $imageUrl');
    }
    return Future.value(loadedFile);
  }

  ///
  /// Checks if file already exists in the cache
  ///
  static Future<String> _tryLoadFromCache(String uniqId) async {
    final String imageFileName = "${await _getStoreFolder()}/$uniqId";
    //print(imageFileName);
    return Future.value(
        await File(imageFileName).exists() ? imageFileName : null);
  }

  ///
  /// Downloads the image and stores in the cache
  ///
  static Future<String> _downloadAndStoreImage(String imageUrl) async {
    try {
      // get file name in the cache
      final String imageFileName =
          '${await _getStoreFolder()}/${extractUniqImageId(imageUrl)}';
      // get response
      final response = await http.get(imageUrl);
      // store to cache
      File(imageFileName).writeAsBytesSync(response.bodyBytes, flush: true);
      return Future.value(imageFileName);
    } on FileSystemException catch (error) {
      print('Save on disk error: ' + error.toString());
    }

    return Future.value(null);
  }

  static Future<String> _getStoreFolder() async {
    final appDir = await syspath.getExternalStorageDirectory();
    final Directory imageFileNameDir = Directory('${appDir.path}/images/');

    if (!(await imageFileNameDir.exists())) {
      await imageFileNameDir.create(recursive: true);
    }

    return Future.value(imageFileNameDir.path);
  }

  ///
  /// Takes the url to google drive and extracts the unique identifier
  ///
  static String extractUniqImageId(String url) {
    if (url.startsWith('https://drive.google.com/file/d/')) {
      // TODO: implement Google Auth
      final id = url
          .substring('https://drive.google.com/file/d/'.length)
          .split('/')[0];
      print(id);
      return id;
    }

    if (url.startsWith('https://drive.google.com/uc?export=download&id=')) {
      return url.split('=').last;
    }

    return path.basename(File(url).path);
  }

  ///
  /// Updates imageUrl from Google Drive
  ///
  static String _prepareUrl(String url) {
    if (url.startsWith('https://drive.google.com/open?id=')) {
      return url.replaceFirst('open?', 'uc?export=download&');
    }
    return url;
  }
}
