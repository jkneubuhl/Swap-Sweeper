function fnOfferingForm() {
    $('#new-offer-add-photo').button( { icons : { primary : 'ui-icon-plusthick' }});
    $('#submit-button').button( { icons : { primary : 'ui-icon-check' }} );
    $('#cancel-button').button( { icons : { primary : 'ui-icon-closethick' }} );
    $('#add-photo-row').data('photo-count', 0);
    $('#new-offer-add-photo').click( function(e) {
            e.preventDefault();
            var count = $('#add-photo-row').data('photo-count');
            count += 1;
            $('#add-photo-row').data('photo-count', count );

            $('#add-photo-input').append( 
                                         "<div class='input-row'>" +
                                         "<div class='input-label'>Photo</div>" + 
                                         "<div class='input-field'><input type='file' id='photo" + count + "' name='photos[p" + count + "]'></div>"  + 
                                         "</div>"
                                          );
            $('#add-photo-input').show();
        });
}