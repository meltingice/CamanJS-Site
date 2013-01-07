// From http://stackoverflow.com/questions/1173194/select-all-div-text-with-single-mouse-click
function selectText() {
  var range;

  if (document.selection) {
      range = document.body.createTextRange();
      range.moveToElementText(this);
      range.select();
  } else if (window.getSelection) {
      range = document.createRange();
      range.selectNode(this);
      window.getSelection().addRange(range);
  }
}

$(document).ready(function () {
  $('body').on('click', '.CopyCommand', selectText);
});