import 'package:http/http.dart'as http;
import 'dart:convert';

class NetworkHelper {

  NetworkHelper({required this.url});

  final String url;

  Future<dynamic> getData() async {
    http.Response response;
    response =  await http.get(Uri.parse(url));

    //Means Success
    if (response.statusCode == 200){
      //json
      String data = response.body;
      //parses json string and return json obj
      dynamic jsonObject = jsonDecode(data);
     return jsonObject ;
    }
    else {
      print(response.statusCode);
    }
  }
}