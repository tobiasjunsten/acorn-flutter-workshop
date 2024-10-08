import 'package:acorn_flutter_workshop/cheat/state/image_state.dart';
import 'package:acorn_flutter_workshop/cheat/ui/components/image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllImagesPage extends StatelessWidget {
  const AllImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ImageState>(context);

    return state.searchResult.isEmpty
        ? const Center(
            child: Text('No images'),
          )
        : LayoutBuilder(
            builder: (context, constraints) => GridView.count(
              crossAxisCount: constraints.maxWidth > 1000
                  ? 6
                  : constraints.maxWidth > 600
                      ? 3
                      : 2,
              children: state.searchResult
                  .map(
                    (imageInfo) => Card(
                      color: Theme.of(context).colorScheme.primary,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute<void>(builder: (context) {
                            return Scaffold(
                              appBar: AppBar(
                                title: Text(imageInfo.title),
                              ),
                              body: ImageDialog(imageInfo: imageInfo),
                            );
                          }));
                        },
                        child: Hero(
                          tag: imageInfo.id,
                          child: Image.network(imageInfo.url),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
  }
}
