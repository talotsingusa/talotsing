// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap.min
//= require jquery.parallaximage
//= require jquery.parallax
//= require jquery.slick
//= require jquery.sliders
//= require jquery.easing
//= require popper
//= require bootstrap-sprockets
//= require datatables
//= require greensock/TweenLite
//= require greensock/easing/EasePack
//= require greensock/jquery.gsap.js
//= require owlcarousel2/owl.carousel
//= require modernizr
//= require parallax
//= require slick
//= require toastr
//= require sq-payment-form
//= require_self
//= require turbolinks
//= require_tree



$('body').css({'overflow' : ''});
var resetForms = function () {
    // this depends on your use
    // this is for foundation 6's abide
    $('form').each(function () {
        $(this).foundation('destroy');
    });
};

document.addEventListener("turbolinks:before-cache", function() {
    resetForms();
});
$( document ).ready(function() {
    $(".notice" ).fadeOut(5000);
});
