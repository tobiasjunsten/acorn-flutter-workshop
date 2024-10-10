import 'package:acorn_flutter_workshop/cheat/state/image_state.dart';
import 'package:acorn_flutter_workshop/cheat/ui/space_home.dart';
import 'package:acorn_flutter_workshop/ui/main_page.dart';
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
      create: (context) => ImageState()..init(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Space Images',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        home: MainPage(),
      ),
    );
  }
}
