import 'package:acorn_flutter_workshop/cheat/ui/components/image_card.dart';
import 'package:acorn_flutter_workshop/cheat/state/image_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikePage extends StatelessWidget {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ImageState>();
    var nasaImage = appState.current;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          nasaImage != null
              ? Expanded(child: ImageCard(image: nasaImage))
              : const Placeholder(),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleCurrentFavorite();
                },
                icon: Icon(
                  appState.favorites.contains(nasaImage)
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                label: const Text('Favorite'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: const Row(
                  children: [
                    Text('Next'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
