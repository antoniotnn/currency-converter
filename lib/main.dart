import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const requestUrl = 'https://api.hgbrasil.com/finance?format=json-cors&key=d5fdd914';

void main() async {
  //print(await getData());

  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        hintStyle: TextStyle(color: Colors.amber),
      )
    ),
    debugShowCheckedModeBanner: false,
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(requestUrl));
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double dolar;
  late double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('\$ Conversor \$'),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: Text(
                    'Carregando Dados...',
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Erro ao Carregar Dados :(',
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Reais',
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: 'R\$'
                          ),
                          style: TextStyle(
                            color: Colors.amber, fontSize: 25.0
                          ),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Dólares',
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: 'US\$'
                          ),
                          style: TextStyle(
                            color: Colors.amber, fontSize: 25.0
                          ),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Euros',
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: '€'
                          ),
                          style: TextStyle(
                            color: Colors.amber, fontSize: 25.0
                          ),
                        )
                      ],
                    ),
                  );
                }
            }
          },
        ));
  }
}

/*

  heme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        hintStyle: TextStyle(color: Colors.amber),
      )),
));

*/