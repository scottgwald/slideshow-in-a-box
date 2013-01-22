# jQuery Image Gallery Plugin

## This branch

The goal of this branch is to be able to turn a folder full of pictures
into a slideshow using very few steps. 

### Requires
* `convert` (ImageMagick)

### Steps
1. Clone.
2. Add your pictures to the img folder. They can be in subdirectories, and (as-is) they must be jpeg's.
3. `make`
4. Adjust `baseURL` in `js/main.js` as appropriate for your server.
5. Push the folder to your server.

### Notes
* The slideshow starts automatically in fullscreen (which is full-window until the user clicks "fullscreen"). This happens because of the `.click()` calls at the end of `js/main.js`.
* `make` does the following: 
    1. looks for all jpeg's in the current directory and all of its subdirectories
    2. produces a thumbnail for each, if it does not exist already. The name is the original with `.thumb.jpg` appended. This can be modified in `helper.bash` if desired.
    3. creates `js/img.json`, which defines a title, thumbnail url, and source url for each. Titles can be modified by hand if others are desired.

## Demo
[jQuery Image Gallery Demo](http://blueimp.github.com/jQuery-Image-Gallery/)

## Description & Usage
The Image Gallery plugin makes use of jQuery's 
[delegate](http://api.jquery.com/delegate/) method to attach
a click event handler for all child elements of a container:

```js
$('#gallery').imagegallery();
```
    
It is possible to override the default selector as well as a number of
additional gallery options:

```js
$('#gallery').imagegallery({
    // selector given to jQuery's delegate method:
    selector: 'a[data-gallery="gallery"]',
    // event handler namespace:
    namespace: 'imagegallery',
    // Shows the next image after the given time in ms (0 = disabled):
    slideshow: 0,
    // Offset of image width to viewport width:
    offsetWidth: 100,
    // Offset of image height to viewport height:
    offsetHeight: 100,
    // Display images fullscreen (overrides offsets):
    fullscreen: false,
    // Display images as canvas elements:
    canvas: false,
    // body class added on dialog display:
    bodyClass: 'gallery-body',
    // element id of the loading animation:
    loaderId: 'gallery-loader',
    // list of available dialog effects,
    // used when show/hide is set to "random":
    effects: [
        'blind',
        'clip',
        'drop',
        'explode',
        'fade',
        'fold',
        'puff',
        'slide',
        'scale'
    ],
    // The following are jQuery UI dialog options, see
    // http://jqueryui.com/demos/dialog/#options
    // for additional options and documentation:
    modal: true,
    resizable: false,
    width: 'auto',
    height: 'auto',
    show: 'fade',
    hide: 'fade',
    dialogClass: 'gallery-dialog'
});
```

The click handler opens the linked images in a jQuery UI dialog.
The options object given to the imagegallery method is passed to the
[jQuery UI dialog](http://jqueryui.com/demos/dialog/) initialization
and allows to override any
[dialog options](http://jqueryui.com/demos/dialog/#options).

It is possible to change options after widget initialization:

```js
$('#gallery').imagegallery('option', 'fullscreen', true);
$('#gallery').imagegallery('option', {
    show: 'slide',
    hide: 'slide'
});
```

The Image Gallery widget can also be disabled/enabled/destroyed:

```js
$('#gallery').imagegallery('disable');
$('#gallery').imagegallery('enable');
$('#gallery').imagegallery('destroy');
```

## Requirements
* [jQuery](http://jquery.com/) v. 1.6+
* [jQuery UI](http://jqueryui.com/) v. 1.8+ (Required: Widget, Dialog)
* [JavaScript Load Image](https://github.com/blueimp/JavaScript-Load-Image) v. 1.1.4+

## License
Released under the [MIT license](http://www.opensource.org/licenses/MIT).
