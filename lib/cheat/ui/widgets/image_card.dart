import 'package:acorn_flutter_workshop/cheat/model/image_info.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.image});

  final NasaImageInfo image;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: <Widget>[
              const Center(child: CircularProgressIndicator()),
              Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'https://picsum.photos/250?image=9',
                ),
              ),
            ],
          )
          // Image.network(image.url),
          ),
    );
  }
}
