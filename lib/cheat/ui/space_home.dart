import 'package:acorn_flutter_workshop/cheat/ui/pages/all_images.dart';
import 'package:acorn_flutter_workshop/cheat/ui/pages/favorites_page.dart';
import 'package:acorn_flutter_workshop/cheat/ui/pages/like_page.dart';
import 'package:flutter/material.dart';

class SpaceHome extends StatefulWidget {
  const SpaceHome({super.key});

  @override
  State<SpaceHome> createState() => _SpaceHomeState();
}

class _SpaceHomeState extends State<SpaceHome> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final page = getPage(currentPageIndex);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
            body: Row(
          children: [
            NavigationRail(
              extended: constraints.maxWidth > 600,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.abc),
                  label: Text('All images'),
                ),
              ],
              selectedIndex: currentPageIndex,
              onDestinationSelected: (value) => {
                setState(() {
                  currentPageIndex = value;
                })
              },
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ));
      },
    );
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const LikePage();
      case 1:
        return const FavoritesPage();
      case 2:
        return const AllImagesPage();
      default:
        return const LikePage();
    }
  }
}
