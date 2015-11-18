// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
    $('#node').submit(function () { // catch the form's submit event
        $.ajax({ // create an AJAX call...
            data: $(this).serialize(), // get the form data
            type: $(this).attr('method'), // GET or POST
            url: $(this).attr('action'), // the file to call
            success: function(response) { // on success..
                $('#list_nam_devices').html(response); // update the DIV
            }
        });
        return false; // cancel original event to prevent form submitting
    });

    $('#lnk_clear_rules').submit(function () { // catch the form's submit event
        $.ajax({ // create an AJAX call...
            data: $(this).serialize(), // get the form data
            type: $(this).attr('method'), // GET or POST
            url: $(this).attr('action'), // the file to call
            success: function(response) { // on success..
                alert('cleared');
            }
        });
        return false; // cancel original event to prevent form submitting
    });
});

(function( $, undefined ) {
    $.notification = function(options) {
        var opts = $.extend({}, {type: 'notice', time: 3000}, options);
        var o    = opts;

        timeout          = setTimeout('$.notification.removebar()', o.time);
        var message_span = $('<span />').addClass('jbar-content').html(o.message);
        var wrap_bar     = $('<div />').addClass('jbar jbar-top').css("cursor", "pointer");

        if (o.type == 'error') {
            wrap_bar.css({"color": "#D8000C"})
        };

        wrap_bar.click(function(){
            $.notification.removebar()
        });

        wrap_bar.append(message_span).hide()
            .insertBefore($('.container')).fadeIn('fast');
    };


    var timeout;
    $.notification.removebar    = function(txt) {
        if($('.jbar').length){
            clearTimeout(timeout);

            $('.jbar').fadeOut('fast',function(){
                $(this).remove();
            });
        }
    };


})(jQuery);


