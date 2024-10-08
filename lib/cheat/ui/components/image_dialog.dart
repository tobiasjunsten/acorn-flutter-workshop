import 'package:acorn_flutter_workshop/cheat/model/image_info.dart';
import 'package:acorn_flutter_workshop/cheat/state/image_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({
    super.key,
    required this.imageInfo,
  });

  final NasaImageInfo imageInfo;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ImageState>(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Card(
            child: Hero(
              tag: imageInfo.id,
              child: Image.network(imageInfo.url),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                state.toggleFavorite(imageInfo.id);
              },
              icon: Icon(
                state.favorites.contains(imageInfo)
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              label: const Text('Favorite'),
            ),
            const SizedBox(width: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
