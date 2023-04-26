import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'pokemon_card.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: "PokeMon App",
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List pokemons = [];

  Future<void> fetchData() async {
    final String response =
        await rootBundle.loadString("./lib/pokemon-data.json");
    final data = await jsonDecode(response);
    setState(() {
      pokemons = data["pokemons"];
    });
    print(pokemons);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PokeDex"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          runSpacing: 20,
          children: [
            ...pokemons.map(
              (e) => PokemonCard(
                imageUrl: e["imageUrl"],
                pokemonName: e["name"],
                pokemonDesc: e["description"],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 34:19
