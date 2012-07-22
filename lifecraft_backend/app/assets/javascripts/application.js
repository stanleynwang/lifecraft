// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

(function($) {

var Lifecraft = (function() {
  var _user = null;

  function _clone(o) {
    return $.extend({}, o);
  }

  function signin(email) {
    $.post('/api/login', {email: email}, function(data) {
      if (!data) {
        // Well, fuck.
        $(document).trigger('auth:signedin', {success: false});
      } else {
        _user = data;
        $(document).trigger('auth:signedin', {success: true, user: getUser()});
      }
    }, 'json');
  }

  function signout() {
    $.ajax({
      type: 'DELETE',
      url: '/api/logout',
      success: function(data) {
        if (!data.success) {
          $(document).trigger('auth:signedout', {success: false});
        } else {
          user = null;
          $(document).trigger('auth:signedout', {success: true});
        }
      }
    });
  }

  function isSignedIn() {
    return !!_user;
  }

  function getUser() {
    return _clone(_user);
  }

  return {
    signin: signin,
    signout: signout,
    isSignedIn: isSignedIn,
    getUser: getUser
  };
})();

$(function() {
  $('ul.nav li a[href!="#"]').click(function() {
    var $e = $(this), $yield = $('#yield'), target = '/_' + $e.attr('href');
    $yield.load(target, function() {
      $('ul.nav li').removeClass('active');
      $e.parent().addClass('active');
    });
    return false;
  });

  $('#get-started').click(function() {
    var $flash = $('<div class="alert alert-info">').html(
      'Sign in on the top right corner with your email address.'
    );
    $(this).parent().replaceWith($flash);
    $('form.signin input[type=email]').focus();
  });

  $('form.signin').submit(function() {
    var email = $(this).find('input[type=email]').val();
    Lifecraft.signin(email);
    $(document).on('auth:signedin', function(data) {
      console.log(data);
    });
    return false;
  });
});

})(jQuery);

