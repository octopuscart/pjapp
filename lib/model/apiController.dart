import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:pj_paul_ministries/model/config.dart';

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
      print(inputdata);

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json"
      };

      var response = await http.post(
        Uri.parse(url),
        headers: ismultilevel ? headers : null,
        body: ismultilevel ? jsonEncode(inputdata) : inputdata,
      );

      if (response.statusCode == 200) {
        print(response.body);
        final parsed = jsonDecode(response.body);
        return (parsed);
      } else {
        throw Exception('Failed to post data ${response.body}');
      }
    } on Exception catch (e) {
      print('never reached $e');
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
