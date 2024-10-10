# acorn_flutter_workshop

A flutter workshop that will build an application displaying NASA space images. The application will have three different pages with different features.

1. A **like image** page which will serve as **home screen** where one single random image will be displayed. There will be two buttons. One that gets the next random image and one that toggles the current image as a favorite.

2. A **favorite gallery** displaying all the favorite images. There will be a possibility to remove images from the favorites.

3. An **all images gallery** displaying all available images. Clicking on an image will open that image in fullscreen and display the name of the image and the possibility to mark the image as favorite.

## Step by step guide
Before we start building anything we should start the application to make sure that everything is working and that we see what's happening when adding new widgets. Press F5 or head over to main.dart and press "run" above the main method or press play button in top right.

### Add Navigation
To get a good starting point working with the different pages we'll start adding a really basic navigation.

**TL;DR**

Widgets to use: A Row containing a NavigationRail and a Container. The Container is wrapped in an Expanded.

State: Convert the MainPage to a StatefulWidget and add currentPageIndex as a variable dealing with the selected destination in the NavigationRail.

Create two new widgets that represents the LikePage and the FavoritesPage. Swap between them when currentPageIndex changes by putting the correct page as child in the Container.


#### Step by step

1. **Add a NavigationRail**  
* Head over to `ui/main_page.dart`
* Remove the Text widget on line 9 and replace it with a NavigationRail containing two destinations and a selectedIndex of 0.  
    ```
    NavigationRail(
        destinations: const [
            NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
            ),
            NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text('Favorites'),
            ),
        ],
        selectedIndex: 0,
    ),
    ```

2. **Add space for content**
* To make some place for the page content, surround the NavigationRail with a Row. Place the cursor on the NavigationRail in the editor and open the "Quick fix" dialog by pressing '⌘.' or '⎇Enter' depending on your keyboard shortcut settings. Then select "Wrap with row".
* Add a Container as a second widget in the children property of the Row.
* Add a color to the Container to see the container's extent. Use the color property of the Container widget. A suggestion is to use a color from the theme.
    ```
    color: Theme.of(context).colorScheme.primaryContainer,
    ```
* Since a container doesn't take up any space if no one tells it to we also need to wrap the Container with an Expanded widget.
* We should now have a navigation to the left and a space to the right where our app's pages will live.

2. **Add state to handle switch pages**
* We'll use a stateful widget to handle which page is selected. Place cursor on the MainPage class name and open "Quich fix". Select "Convert to StatefulWidget".
* Add a variable in the state class that will handle the index of the slected page.
    ```
    int currentPageIndex = 0;
    ```
* Use the currentPageIndex variable in the selectedIndex property of the NavigationRail.
* Add a function that will update the currentPageIndex when a new destination is selected. Add the function in the property onDestinationSelected of the NavigationRail.
    ```
    onDestinationSelected: (value) => {
        setState(() {
            currentPageIndex = value;
        })
    },
    ```
* It should now be possible to select destination in the navigation rail.

3. **Switch page when destination is changed**
* Create two widgets to represent the two different pages. Place the cursor below the MainPage and type stl. Chose "Flutter Stateless Widget" in the dialog that opens. Name the widget LikePage. Create one more stateless widget and call that one FavoritesPage
* Create a variable at the top of the build method in _MainPageState that represents the selected page and assign the child property of the Container to the variable.
    ```
    final page =
        currentPageIndex == 0 ? const LikePage() : FavoritesPage();
    ```
* As a last step, move the two widgets LikePage and FavoritesPage to their own files. Can be done using "Quick fix". Put the files inside a folder called ui/pages.

### Home page (LikePage)
The LikePage will serve as our home page and will have the capability to display a random image and the possibility to add the image to the favorites.

**TL;DR**

Widgets to use: Column, Center, SizedBox, Row, ElevatedButton, Card, FadeInImage, Padding, Icon, Text.

Use the state that is provided at the very top of the application (SpaceImagesApp widget). This is done by watching the state like this at the top of the build method that is dependant on the state:
```
var appState = context.watch<ImageState>();
```

Inside the state there is a model for the currentImage and also a function to call when a new random image should be selected.

#### Step by step

1. **Display the current image**
* To display the current image we need the state to tell us which the current image is. So start watching the state by adding this line at the top of the build method in the LikePage:
    ```
    var appState = context.watch<ImageState>();
    ```
* Return a FadeInImage from the build method using the url from the currentImage inside the appState.
    ```
    final currentImage = appState.currentImage;
    return currentImage != null
        ? FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: currentImage.url,
          )
        : Placeholder();
    ```
    *We declare the local variable currentImage to be able to promte the nullable variable currentImage to a non-nullable and not needing to use the bang operator (!).*

2. **Display the next random image**
* We want a button below the image that gets the next image. Wrap the FadeInImage with a Column and add an ElevatedButton as the second child in the Column.
* Call the function appState.getNext() in the button's onPressed property.
* Pressing next should now display a new image. There might be some delay when switching image since the new image needs to be fetch from the internet. This could be fixed by preloading images to memory or adding a spinner for a better user experience.

3. **Set an image as favorite**
* We need another button next to the Next-button. Wrap the Next-button with a Row and add a new ElevatedButton as the first child with the text "Favorite".
* Connect the onPressed property of the Favorite-button to the method appState.toggleCurrentFavorite.
* To have some indication that the Favorite-button had any effect we also add an icon to the Favorite-button that changes between filled and unfilled depending on the state
    ```
    ElevatedButton.icon(
        onPressed: () {
            appState.toggleCurrentFavorite();
        },
        icon: Icon(
            appState.favorites.contains(currentImage)
                ? Icons.favorite
                : Icons.favorite_border,
        ),
        label: const Text('Favorite'),
        ),
    ```

4. **Enhance layout and create custom widgets**
* Wrap the image with a Card.
* Wrap the image with a Padding to make the Card more visible.
* Extract an own widget from the Card calling it ImageCard.
* Make the currentImage variable in the ImageCard non-nullable and only display an ImageCard if there is an image. Otherwise display an empty Card.
* Center the buttons by setting the property mainAxisSize to MainAxisSize.min of the Row holding the buttons.


### Favorite gallery (FavoritesPage)
It's time to display the favorites in an image gallery.

**TL;DR**

Widgets to use: Center, GridView, Stack, Positioned, GestureDetector

#### Step by step
1. **Display number of favorites**
* In the build method get the state like before:
    ```
    var appState = context.watch<ImageState>();
    ```
* Use the favorites in the state and display an empty message if it's empty and otherwise a message saying there are x favorites.
    ```
    return appState.favorites.isEmpty
        ? const Center(
            child: Text('No favs yet...'),
            )
        : Center(
            child: Text('There are ${appState.favorites.length} favs'),
            );
    ```

2. **Display the favorite images**
* Replace the Text part that is displayed when there are favorites with a GridView. We use the GridView.count counstructor where the number of columns can be specified.
    ```
    GridView.count(
        crossAxisCount: 2,
        children: appState.favorites.map((imageInfo) {
            return Image.network(
            imageInfo.url,
            fit: BoxFit.cover,
            );
        }).toList(),
        );
    ```

3. **Make it possible to remove favorite**
* Wrap the image Image.network with a Stack. Make sure to set the property fit to StackFit.expand in the Stack to keep the cover fit for the Image.
* Add a Positioned widget to the Stack and add an Icon displaying a heart at the bottom left. To accomplish this use the properties bottom and left of the Positioned. Set them to a low value like 8.
* Wrap the Icon displaying the heart with a GestureDetector and set the onTap property to update the favorite in the state.
    ```
    onTap: () {
        state.toggleFavorite(imageInfo.id);
    },
    ```


### All images gallery (AllImagesPage)
The all images gallery should display all available images in a GridView.

It should be possible to tap an image to open it in a new route. To push a new route Navigator is used:
```
Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(imageInfo.title),
        ),
        body: ImageDialog(imageInfo: imageInfo),
    );
}));
```

ImageDialog is a new widget that should be created that displays the Image.

Use the Hero widget to get a cool animation when opening an image in fullscreen. To use the Hero widget each widget in the gallery needs to be wrapped with a Hero widget and the tag of the Hero widget should be the id of the image. In the ImageDialog that is displaying the image the image needs to be wrapped with a Hero using the same tag (the id of the image that is displayed).

In the GridView
```
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
```

In the ImageDialog:
```
Hero(
    tag: imageInfo.id,
    child: Image.network(imageInfo.url),
)
```