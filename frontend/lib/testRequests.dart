import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class testRequest extends StatelessWidget {
  testRequest({super.key});

  Future<Response> fetchData() async {
    String url = 'https://jsonplaceholder.typicode.com/albums/1';
    final resp = await get(url);
    print(json.decode(resp.body));
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black26,
        appBar: AppBar(
          title: const Text("GainsTrack"),
          centerTitle: true,
          backgroundColor: Colors.orange[400],
          foregroundColor: Colors.red[900],
        ),
        body: Center(
          child: Column(
            children: [
              const Text(
                "test Screen",
                style: TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  Future<Response> resp = fetchData();
                },
                child: const Text("Get"),
              ),
            ],
          ),
        ));
  }
}
