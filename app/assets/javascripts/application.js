//= require jquery.min
//= require admin/jquery.noty
//= require admin/layouts/bottom
//= require admin/layouts/topRight
//= require admin/layouts/top
//= require admin/themes/default
//= require jquery_ujs
//= require bootstrap
//= require admin/bootstrap-datetimepicker.min
//= require jquery.isotope
//= require jquery.prettyPhoto
//= require filter
//= require jquery.tweet
//= require jquery.flexslider-min
//= require jquery.cslider
//= require modernizr.custom.28468
//= require jquery.carouFredSel-6.1.0-packed
//= require jquery.refineslide.min

//= require cocoon

//= require_self
//= require custom


  $(function() {
    $(".datetimepicker").datetimepicker({
      pickTime: true,
      pickDate: true,
      pickSeconds: true,
      language: "ru-RU"
    });
  });


$(document).ready(function() {

  // example showing manipulating the inserted/removed item

  $("#admission_items")
    .bind("cocoon:before-insert", function(e,task_to_be_added) {
      task_to_be_added.fadeIn("fast");
    })
    // .bind("cocoon:after-insert", function(e, added_task) {
      // e.g. set the background of inserted task
      // added_task.css("background","silver");
    // })
    .bind("cocoon:before-remove", function(e, task) {
      // allow some time for the animation to complete
      $(this).data("remove-timeout", 300);
      // task.fadeOut("fast");
      task.animate({ height: "0px", opacity: 0 }, 300 );
    });

  $("#release_items")
    .bind("cocoon:before-insert", function(e,task_to_be_added) {
      task_to_be_added.fadeIn("fast");
    })
    // .bind("cocoon:after-insert", function(e, added_task) {
      // e.g. set the background of inserted task
      // added_task.css("background","silver");
    // })
    .bind("cocoon:before-remove", function(e, task) {
      // allow some time for the animation to complete
      $(this).data("remove-timeout", 300);
      // task.fadeOut("fast");
      task.animate({ height: "0px", opacity: 0 }, 300 );
    });
    
});