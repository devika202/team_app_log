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
//= require rails-ujs
//= require turbolinks
//= require chartkick
//= require Chart.bundle
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require my_validation_script
//= require jquery-ui
import "jquery-ui"
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
$(document).on('turbolinks:load', function() {
  $('[data-autocomplete-source]').each(function() {
    var source = JSON.parse($(this).data('autocomplete-source'));
    $(this).autocomplete({
      source: function(request, response) {
        var term = request.term.toLowerCase();
        var filteredSuggestions = source.filter(function(suggestion) {
          return suggestion.toLowerCase().indexOf(term) === 0;
        });
        response(filteredSuggestions.slice(0, 5));
      },
      appendTo: '#tag-suggestions',
      select: function(event, ui) {
        $(this).val(ui.item.value);
        $(this).closest('form').submit();
        return false;
      }
    });
  });
});


