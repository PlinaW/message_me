// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require semantic-ui
import "@hotwired/turbo-rails"
import "controllers"

import "jquery"
import "semantic-ui"

import "channels"



$(document).on('turbo:load', function () { 
  $('.ui.dropdown').dropdown();
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });
})


$(document).on('turbo:load', function() {
  if ($('#messages').length > 0) {
  $('#messages').scrollTop($('#messages')[0].scrollHeight);
  }
})