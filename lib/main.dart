import 'package:acorn_flutter_workshop/cheat/state/image_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const SpaceImagesApp());
}

class SpaceImagesApp extends StatelessWidget {
  const SpaceImagesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Space Images',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Welcome to the Space Images App!'),
    );
  }
}
