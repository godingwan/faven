$(document).ready(function() {
  function goLeft() {
    $(this).addClass('flipper')
    $('#airplane').animate({left: "-=2200"}, 15000, "swing", goRight);
  }
  function goRight() {
    $(this).removeClass('flipper')
    $('#airplane').animate({left: "+2000"}, 20000, "swing", goLeft);
  }
  goRight();
});

