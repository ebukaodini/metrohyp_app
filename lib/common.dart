import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

Future fetch(BuildContext context, String uri,
    {String method, dynamic body, dynamic headers}) async {
  String baseUrl = "https://services.metrohyp.com";
  var response;
  switch (method) {
    case 'GET':
      response = await http.get(baseUrl + uri, headers: headers);
      break;
    case 'POST':
      response = await http.post(baseUrl + uri, headers: headers, body: body);
      break;
    case 'PATCH':
      response = await http.patch(baseUrl + uri, headers: headers, body: body);
      break;
    case 'PUT':
      response = await http.put(baseUrl + uri, headers: headers, body: body);
      break;
    case 'DELETE':
      response = await http.delete(baseUrl + uri, headers: headers);
      break;
    default:
      response = await http.get(baseUrl + uri, headers: headers);
      break;
  }
  print("\n\n" + uri + " => " + response.body + "\n\n");
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 400 ||
      response.statusCode == 401 ||
      response.statusCode == 403) {
    error(context, response.statusText, title: 'Request Error');
    return false;
  } else {
    error(context, response.statusText, title: 'Network Error');
    return false;
  }
}

void loading(BuildContext context, {String message: 'Loading'}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new CircularProgressIndicator(),
            new Text("     $message..."),
          ],
        ),
      );
    },
  );
}

void message(BuildContext context, String message, {String title: 'Message'}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          scrollable: true,
          title: Row(
            children: [
              Icon(Icons.info, color: Colors.lightBlueAccent),
              SizedBox(width: 2.0),
              Text("$title", style: TextStyle(color: Colors.lightBlueAccent)),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          content:
              Text(message, style: TextStyle(color: Colors.lightBlueAccent)),
          backgroundColor: Colors.white);
    },
  );
}

void success(BuildContext context, String message, {String title: 'Message'}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: Row(
          children: [
            Icon(Icons.done, color: Colors.green),
            SizedBox(width: 2.0),
            Text("$title", style: TextStyle(color: Colors.green)),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        content: Text(message, style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
      );
    },
  );
}

void error(BuildContext context, String message, {String title: 'Error'}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 2.0),
            Text("$title", style: TextStyle(color: Colors.red)),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        content: Text(message, style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.white,
      );
    },
  );
}
