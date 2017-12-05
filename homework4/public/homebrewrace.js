;

$(document).ready(function() {

    $('#submitRace').click(function() {
        
                $.post('/newRace', {rname: $('#race_name').val(), desc: $('#race_desc').val(), buff1: $('#buff1').val(),
                buff2: $('#buff2').val(), b1where: $('#b1where').val(), b2where: $('#b2where').val(), penalty: $('#penalty').val(),
            pwhere: $('#pwhere').val()}, function(data) {
        
                    $('#raceError').append(data)
        
                });
        
        
            });

});