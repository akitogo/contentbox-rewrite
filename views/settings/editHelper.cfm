<script>
	// Open Popup for selecting stored content objects
	var input = null;
    var hidden = null;
    $( document ).ready(function() {
        $( '.select-content' ).on( 'click', function() {
            input = $( this ).siblings( 'input' );
            hidden= $( '#contentid' );
            var baseURL = '<cfoutput>#event.buildLink( prc.cbAdminEntryPoint & ".content.showRelatedContentSelector" )#</cfoutput>';
            openRemoteModal( baseURL, {contentType:'Page,Entry'}, 900, 600 );
        });
    });
	
	// This function is called if a content object was selected from popup.
    function chooseRelatedContent( id, title, type, slug ) {
        closeRemoteModal();
        input.val( title );
        hidden.val( id );
        return false;
    }
	
</script>