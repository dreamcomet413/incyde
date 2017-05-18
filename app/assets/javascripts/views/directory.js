var $ = require('jquery');

// TODO: Esto se puede mejorar haciendo lo siguiente, definiendo
// los siguientes estados para el elemento .content de cada
// mensaje: is-sending (para cuando está enviando), is-closed (para cuando
// está el botón de Responder) e is-open (para cuando está el textarea).

module.exports = function() {

  function hideNewContact(e) {

  }

  function hideNewMessage(e) {
    e.preventDefault();
    $('#new-message-button').removeClass('invisible');
    $('#new-message').addClass('invisible');
  }

  function showNewMessage() {
    e.preventDefault();
    $('#new-message').removeClass('invisible');
  }

  $('#contacts').addClass('invisible');
  $('#new-message').addClass('invisible');

  $('#new-message-button')
    .on('click', function(e) {

      e.preventDefault();

      $(this).addClass('invisible');

      $('#new-message')
        .removeClass('invisible')
        .find('[href="#cancel"]')
        .one('click', hideNewMessage);

    });

  function send(e) {

    e.preventDefault();

    $(this).parents('.reply').addClass('invisible');
    $(this).parents('.content').find('[href="#answer"]').removeClass('invisible');

  }

  function cancel(e) {

    e.preventDefault();

    $(this).parents('.reply').addClass('invisible');
    $(this).parents('.content').find('[href="#answer"]').removeClass('invisible');

  }

  function showAnswer(e) {
    e.preventDefault();
    var $this = $(this);
    $this
      .addClass('invisible')

    var $reply = $this
      .siblings('.reply')
      .removeClass('invisible');

    $reply.find('[href="#send"]').off('click').on('click', send);
    $reply.find('[href="#cancel"]').off('click').on('click', cancel);
  }

  $('[href="#answer"]').off('click').on('click', showAnswer);

  $('.ui.dropdown').dropdown({
    onChange: function(value,text) {

      console.log(value,text);

      $('#new-message').addClass('invisible');

      if (value === 'messages') {

        $('#messages').removeClass('invisible');
        $('#contacts').addClass('invisible');

        $('#new-message-button')
          .removeClass('invisible')
          .on('click', showNewMessage);

      } else {

        $('#messages').addClass('invisible');
        $('#contacts').removeClass('invisible');

        $('#new-message-button')
          .addClass('invisible')
          .off('click');

      }
    }
  });

};
