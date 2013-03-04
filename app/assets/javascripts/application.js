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
//= require_self
//= require custom


  $(function() {
    $('.datetimepicker').datetimepicker({
      pickTime: true,
      pickDate: true,
      pickSeconds: true,
      language: 'ru-RU'
    });
  });