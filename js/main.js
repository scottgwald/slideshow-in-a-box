/*
 * This example by swgreen adapted from the following
 * original example referenced below. 
 *
 * Also licensed under the MIT license.
 *
 * Prepared for github on Jan 22, 2012.
 *
 * Adapted from:
 * jQuery Image Gallery Plugin JS Example 2.2
 * https://github.com/blueimp/jQuery-Image-Gallery
 *
 * Copyright 2011, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/*jslint unparam: true, regexp: true */
/*global $, document, window */

$(function () {
    'use strict';

    var baseURL = "";
    //var baseURL = "http://www.example.com"

    // Initialize the Image Gallery widget:
    $('#gallery').imagegallery();

    // Initialize the theme switcher:
    $('#theme-switcher').change(function () {
        var theme = $('#theme');
        theme.prop(
            'href',
            theme.prop('href').replace(
                /[\w\-]+\/jquery-ui.css/,
                $(this).val() + '/jquery-ui.css'
            )
        );
    });

    // Create a buttonset out of the checkbox options:
    $('#buttonset').buttonset();

    // Listen to options changes:
    $('#buttonset input, #effect').change(function () {
        $('#gallery').imagegallery('option', {
            show: 'random', //$('#effect').val(),
            hide: 'random', //$('#effect').val(),
            fullscreen: $('#option-fullscreen').is(':checked'),
            slideshow: 5000 //$('#option-slideshow').is(':checked') && 5000
        });
    });

    // Enable real fullscreen mode:
    $('#option-fullscreen').click(function () {
        var checkbox = $(this),
            root = document.documentElement;
        if (checkbox.is(':checked')) {
            if (root.webkitRequestFullScreen) {
                root.webkitRequestFullScreen(
                    window.Element.ALLOW_KEYBOARD_INPUT
                );
            } else if (root.mozRequestFullScreen) {
                root.mozRequestFullScreen();
            }
        } else {
            (document.webkitCancelFullScreen ||
                document.mozCancelFullScreen ||
                $.noop).apply(document);
        }
    });

    console.log("Greetings from main.js.");

    var myGallery = $('#gallery');
 
    $.getJSON('js/img.json', function(myPhotos1) {

        $.each(myPhotos1, function (index, photo) {
            $('<a data-gallery="gallery"/>')
                .append($('<img>').prop('src',baseURL+photo.thumb))
                .prop('href',baseURL+photo.src)
                .prop('title',photo.title)
                .appendTo(myGallery)
        });
        console.log("Done, oh yeah.");console.log(myPhotos1); // semicolon?
        console.log("Clicking fullscreen button.");
        $('#option-fullscreen').click();
        console.log("Clicking first thumbnail.");
        $('#gallery').children()[0].click();
    });

});
