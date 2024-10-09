import 'package:acorn_flutter_workshop/cheat/ui/components/image_card.dart';
import 'package:acorn_flutter_workshop/cheat/state/image_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikePage extends StatelessWidget {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ImageState>();
    var nasaImage = appState.currentImage;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child:
                nasaImage != null ? ImageCard(image: nasaImage) : const Card(),
          ),
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
                  appState.loadNextImage();
                },
                child: Text('Next'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
