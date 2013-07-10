var c = document.querySelector('canvas');
var cx = c.getContext('2d');
var mousedown = false;
var oldx = null;
var oldy = null;

function setupCanvas() {
  c.height = 480;
  c.width = 960;
  cx.lineWidth = 10;
  cx.lineCap = 'round';
  cx.strokeStyle = 'rgb(0, 0, 50)';
}
function onmousedown(ev) {
  mousedown = true;
  oldx = ev.clientX;
  oldy = ev.clientY;
  ev.preventDefault();
}
function onmouseup(ev) {
  mousedown = false;
  ev.preventDefault();
}
function onmousemove(ev) {
  var x = ev.clientX;
  var y = ev.clientY;
  if (mousedown) {
    paint(x, y);
  }
}
function paint(x, y) {
  if (oldx > 0 && oldy > 0) {
    cx.moveTo(oldx, oldy);
  }
  cx.lineTo(x, y);
  cx.stroke();
  oldx = x;
  oldy = y;
}

c.addEventListener('mousedown', onmousedown, false);
c.addEventListener('mouseup', onmouseup, false);
c.addEventListener('mousemove', onmousemove, false);

setupCanvas();

// jquery version
$('#canvas_div').hide();

// javascript version of top
// var canvas = document.getElementById('canvas_div');
// canvas.style.display = 'none';
