import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:pj_paul_ministries/model/config.dart';

class HTTPCallResponse {
  final int status;
  final Map response;
  final Map? error;
  HTTPCallResponse({
    required this.status,
    required this.response,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return {'status': status, 'response': response};
  }

  set setStatus(int status) {
    status = status;
  }

  set setResponse(Map response) {
    response = response;
  }

  set setError(Map error) {
    error = error;
  }

  factory HTTPCallResponse.fromJson(Map<String, dynamic> json) {
    return HTTPCallResponse(
      status: json["status"],
      response: json["response"],
      error: json["status"],
    );
  }
}

class ApiController {
  final String apiendpoint = base_apiendpoint;
  Future getDataFromServerList(url_sufix) async {
    String url = '${this.apiendpoint}/$url_sufix';
    print(url);
    try {
      final http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        return (parsed);
      } else {
        throw Exception('Failed to load data');
      }
    } on Exception catch (_) {
      print('never reached');
    }
  }

  Future getDataFromServerMap(url_sufix) async {
    String url = '${this.apiendpoint}/$url_sufix';
    print(url);
    try {
      final http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final parsed = jsonDecode(response.body);
        return (parsed);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } on Exception catch (e) {
      print('never reached $e');
    }
  }

  Future postCall(Map inputdata, url_sufix, {bool ismultilevel = false}) async {
    try {
      String url = '${this.apiendpoint}$url_sufix';
      print(url);

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json"
      };
      inputdata["apikey"] =
          "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";
      var response = await http.post(
        Uri.parse(url),
        headers: ismultilevel ? headers : null,
        body: ismultilevel ? jsonEncode(inputdata) : inputdata,
      );
      HTTPCallResponse responseData =
          HTTPCallResponse(status: response.statusCode, response: {});
      if (response.statusCode == 200) {
        print(response.body);
        final parsed = jsonDecode(response.body);
        responseData.setResponse = parsed;
      } else {
        responseData.setStatus = 500;
        responseData.setError = {
          "errorCode": "POST100",
          "errorMessage": "Failed to submit data",
          "errorData": response.body
        };
        // throw Exception('Failed to post data ${response.body}');
      }
      return (responseData);
    } catch (e) {
      HTTPCallResponse responseData =
          HTTPCallResponse(status: 404, response: {});
      responseData.setError = {
        "errorCode": "POST101",
        "errorMessage": "Failed to connect server",
        "errorData": e
      };
      // print('never reached $e');
      return responseData;
    }
  }

  Future<void> launchInBrowser(String urlsufix) async {
    final Uri toLaunch =
        Uri(scheme: 'https', host: '$base_url', path: '$urlsufix');
    if (!await launchUrl(
      toLaunch,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $toLaunch';
    }
  }

  Future<void> launchUrlExternal(String urllink) async {
    final Uri _url = Uri.parse(urllink);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> launchInBrowserExt(String urlsufix) async {
    final Uri toLaunch = Uri(scheme: 'https', host: '$urlsufix');
    if (!await launchUrl(
      toLaunch,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $toLaunch';
    }
  }
}
