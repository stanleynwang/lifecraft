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

(function($, window) {
"use strict";

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

  function signout(silent) {
    silent = silent || false;

    $.ajax({
      type: 'DELETE',
      url: '/api/logout',
      success: function(data) {
        if (!data.success) {
          $(document).trigger('auth:signedout', {success: false, silent: silent});
        } else {
          _user = null;
          $(document).trigger('auth:signedout', {success: true, silent: silent});
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
window.Lifecraft = Lifecraft;

$(function() {
  $('#user-info-template').template('userInfo');

  var $fullProgressbar = $('<div class="progress progress-striped active span3">');
  $('<div class="bar">').css('width', '100%').appendTo($fullProgressbar.css({
    marginBottom: '0', marginTop: '9px'
  }));

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
    var $e = $(this), $email = $e.find('input[type=email]');
    var email = $email.val();
    $email.hide();
    $email.after($fullProgressbar);
    // $e.find('button').prop('disabled', true);

    Lifecraft.signin(email);
    return false;
  });

  $(document).on('auth:signedin', function(event, data) {
    if (data.success) {
      if (data.user.notice && data.user.notice == 'must be logged out') {
        Lifecraft.signout(true);
      } else {
        var $userInfo = $.tmpl('userInfo', data.user);
        $('form.signin').replaceWith($userInfo);
      }
    } else {
      $fullProgressbar.replaceWith($('<div class="alert alert-error">').html(
        'An error occured while signing in.'
      ));
    }
  });

  $(document).on('click', 'ul.userinfo a.signout', function(event) {
    Lifecraft.signout();
    return false;
  });

  $(document).on('auth:signedout', function(event, data) {
    if (!data.silent) {
      window.location.reload();
    } else {
      $('form.signin').submit();
    }
  });
});

})(jQuery, window);

