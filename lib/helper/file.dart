import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'outputs.dart';

Future<File?> pickImage({bool gallerySource = false}) async {
  final ImagePicker _picker = ImagePicker();
  try {
    XFile? img = await _picker.pickImage(
      source: gallerySource ? ImageSource.gallery : ImageSource.camera,
      // maxHeight: 500,
      // maxWidth: 500
      //  imageQuality: ImageSource.gallery == source ? 10 : 4
    );
    File? image;
    if (img != null) {
      image = File(img.path);
    }
    return image;
  } catch (e) {
    print('Error picking image: $e');
    // Gérez l'erreur ici pour éviter le crash
    return null;
  }
}

Future<List<File>> pickMultipleImage() async {
  final ImagePicker _picker = ImagePicker();
  try {
    List<XFile> img = await _picker.pickMultiImage();
    List<File> image = [];
    for (var item in img) {
      image.add(File(item.path));
    }
    return image;
  } catch (e) {
    print('Error picking image: $e');
    // Gérez l'erreur ici pour éviter le crash
    return [];
  }
}

urlsize(url) async {
  http.Response? r = await http.head(Uri.parse(url));
  return r.headers["content-length"];
}

Future<String> sizeFromUrl(String? filePath, [precision = 2]) async {
  int bytes = await int.parse(await urlsize(filePath));
  if (bytes != 0) {
    final double base = math.log(bytes) / math.log(1024);
    final suffix = const ['B', 'KB', 'MB', 'GB', 'TB'][base.floor()];
    final size = math.pow(1024, base - base.floor());
    return '${size.toStringAsFixed(2)} $suffix';
  } else {
    return "0B";
  }
}

String sizeFromFile(String filePath, [precision = 2]) {
  var bytes = File(filePath).statSync().size;
  // log(bytes1.toString());
  printIfDebug('taille : $bytes bytes');
  if (bytes != 0 && bytes != -1) {
    final double base = math.log(bytes) / math.log(1024);
    final suffix = const ['B', 'KB', 'MB', 'GB', 'TB'][base.floor()];
    final size = math.pow(1024, base - base.floor());
    return '${size.toStringAsFixed(2)} $suffix';
  } else if (bytes == -1) {
    return "erreur!";
  } else {
    return "0B";
  }
}

Future<bool> shareData({required String text, List<XFile>? files}) async {
  if (files == null) {
    final result = await Share.share(text);
    return result.status == ShareResultStatus.success;
  } else {
    final result = await Share.shareXFiles(files, text: text);
    result.status == ShareResultStatus.success;
  }
  return false;
}
