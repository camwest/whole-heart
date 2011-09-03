$(document).ready(function() {
  var activeExtension = "_active.gif";
  var standardExtension = ".gif";

  $('ul#navigation img').each(function() {
    preloadImage = new Image();
    preloadImage.src = activeImage(this);
  });

  $('ul#navigation img').hover(hoverIn, hoverOut);

  function hoverIn() {
    $(this).attr('src', activeImage(this));
  }

  function hoverOut() {
    $(this).attr('src', standardImage(this));
  }

  function activeImage(element) {
    return imagePath(element, standardExtension, activeExtension);
  }

  function standardImage(element) {
    return imagePath(element, activeExtension, standardExtension);
  }

  function imagePath(element, searchExtension, returnExtension) {
    var match = imageMatch(element, searchExtension);
    var imagePath = match[1];
    var imageRoot = match[2];
    return imagePath + "/" + imageRoot + returnExtension;
  }

  function imageMatch(element, tail) {
    var imageSrc = $(element).attr('src');
    return imageSrc.match( new RegExp("(.*)\/(.*)" + tail ));
  }

});


