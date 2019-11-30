import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:epaisa_pos/data/initial/countries/api_service.dart';
import 'package:epaisa_pos/src/widgets/utils/request_helper.dart';
import 'package:http_parser/http_parser.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

void UploadImage(String path, File imageFile) async {
  Image image = decodeImage(imageFile.readAsBytesSync());
  Image thumbnail = copyResize(image, height: 120, width: 120);

  File newImage = imageFile..writeAsBytesSync(encodePng(thumbnail));

  try {
    var stream =
        new http.ByteStream(DelegatingStream.typed(newImage.openRead()));
    var length = await newImage.length();

    var uri = Uri.parse("$baseUrl$path");
    print("pass");
    var request = new http.MultipartRequest("PUT", uri);
    var multipartFile = new http.MultipartFile('logo', stream, length,
        filename: basename(newImage.path),
        contentType: MediaType('http.', 'png'));
    await getToken((val) async {
      request.headers.addAll({"Authorization": val});
      request.files.add(multipartFile);
      var response = await request.send();
      print("PHOTO $response");
      //print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print("uplaod" + value);
      });
    });
  } catch (e) {
    print("ErrorFAIL");
    print(e);
  }
}

void UploadFiles(String path, File file) async {
  try {
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();

    var uri = Uri.parse("$baseUrl$path");
    print("pass");
    var request = new http.MultipartRequest("PUT", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(file.path), contentType: MediaType('http.', 'png'));
    await getToken((val) async {
      request.headers.addAll({"Authorization": val});
      request.files.add(multipartFile);
      var response = await request.send();
      print("PHOTO $response");
      //print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print("uplaod" + value);
      });
    });
  } catch (e) {
    print("ErrorFAIL");
    print(e);
  }
}

void downloadKYC(String companyId, String type, Function callback) async {
  var url = "$baseUrl/download/companies/$companyId/kyc/$type";
  downloadFile(url, "type", callback);
}

void downloadFile(String path, String directory, Function callback) async {
  print("READY");
  Dio dio = new Dio();
  var token = await getauthkey();
  dio.options.headers = {"Authorization": token};
  var dir = await getApplicationDocumentsDirectory();
  await dio.download(path, "${dir.path}/$directory.pdf",
      onReceiveProgress: (rec, total) {
    String progressString = ((rec / total) * 100).toStringAsFixed(0);
    print("ALMOST $progressString");
    if (progressString == "100") {
      callback();
      print("READY");
      openFile(directory);
    }
  });
}

void openFile(String path) async {
  var dir = await getApplicationDocumentsDirectory();
  OpenFile.open("${dir.path}/$path.pdf");
}
