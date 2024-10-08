import 'package:acorn_flutter_workshop/cheat/state/image_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ImageState>(context);

    return state.favorites.isEmpty
        ? const Center(
            child: Text('No favs yet...'),
          )
        : GridView.count(
            crossAxisCount: 2,
            children: state.favorites
                .map(
                  (imageInfo) => Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: Stack(children: [
                      Center(child: Image.network(imageInfo.url)),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: GestureDetector(
                          onTap: () {
                            state.toggleFavorite(imageInfo.id);
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
                  ),
                )
                .toList(),
          );
  }
}
