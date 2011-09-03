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


  if($('#banner').length > 0) {
    $('header').hide();
    $('#monogram').css('opacity', 0);

    var banner = $('#banner');
    var image = new Image();
    $(image).load(function() {
      $(this).css('position', 'absolute');
      $(this).css('top','3px');
      $(this).attr('width', banner.width() );
      $(this).attr('height', banner.height() );

      $('#banner').before(image);
      $('header').delay(1500).slideDown(1000);
      $('#monogram').delay(2500).animate({ opacity: 1 }, 2000);

      $(image).hide().delay(1500).fadeIn(2000, function() {
        $(image).css('position', 'inherit');
        $(image).attr('width', '');
        $(image).attr('height', '');
        $(image).css('display','inline');
        $(image).css('top','');
        banner.remove();
      });
    });

    image.src = "/images/banner_b&w.jpg";
  }

  
});


