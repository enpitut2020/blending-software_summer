//= require jquery3
//= require popper
//= require bootstrap-sprockets


$(".colorful").children().addBack().contents().each(function () {
  if (this.nodeType == 3) {
    var $this = $(this);
    $this.replaceWith($this.text().replace(/(\S)/g, "<span>$&</span>"));
  }
});
