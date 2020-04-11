$(document).ready(function(){
    $('.new-session-tab-toggle').click(function(event){
        event.preventDefault();
        let activePaneId = $(this).attr('href');
        $('.new-session-tab-toggle.active').each(function(){
            $(this).removeClass('active');
        })
        $(this).addClass('active');
        $('.new-session-tab.active').each(function(){
            $(this).removeClass('active');
            $(this).addClass('fade');
        });
        $(activePaneId).each(function(){
            $(this).removeClass('fade');
            $(this).addClass('active');
        })
    })
})