jQuery(function($){
    $(document).ready(function () {

        // side menu for mobile version
        $('#toggle-nav').click(function(){
            var screenn_width = $('#body-container').width();
            if($('#sidebar').hasClass('sidebar-default')) {
                $('#sidebar').animate({width: screenn_width/2}, 300, function(){
                    $('#sidebar').removeAttr('style');
                    $('#sidebar').removeClass('sidebar-default');
                    $('#mainbar').removeClass('col-xs-12');
                    $('#mainbar').addClass('col-xs-6');
                    $('#toggle-nav').addClass('toggle-hide');
                });
            }else {
                $('#sidebar').width($('#sidebar').width());
                $('#mainbar').removeClass('col-xs-6');
                $('#sidebar').animate({width: 0}, 300, function(){
                    $('#sidebar').removeAttr('style');
                    $('#sidebar').addClass('sidebar-default');
                    $('#mainbar').addClass('col-xs-12');
                    $('#toggle-nav').removeClass('toggle-hide');
                });
            }
        });

        // activate chosen
        $('.chosen-select').chosen();

    });
});