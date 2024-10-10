// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import jquery from "jquery"
import "@hotwired/turbo-rails"
import "controllers"
import "@hotwired/turbo-rails"
import "semantic-ui"

$(document).on('turbo:load', function() {
  console.log('loaded turbo links')

  $('#search').on('keydown', function(event) {
    if (event.key === 'Enter') {
      searchStocks();
    }
  });

  $('.close')
  .on('click', function() {
    $(this)
      .closest('.message')
      .hide()
    ;
  })
;
});

window.$ = jquery
window.jQuery = jquery



function searchStocks() {
  var searchValue = document.getElementById("search").value;
  window.location.href = "/stocks/prices?stock=" + searchValue;
}