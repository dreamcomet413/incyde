var $ = require('jquery');

module.exports = function() {

  $(window).on('resize', function() {
    $('video').fill('cover');
  }).trigger('resize');

  // Dropdown behaviour
  $('#searchbar').find('.ui.dropdown').dropdown();

  // Behaviour for the more-info button.
  $('[href="#more-info"]').on('click', function(e) {

    e.preventDefault();
    $('#home').toggleClass('folded unfolded');

  });

};
