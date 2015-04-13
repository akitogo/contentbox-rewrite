<cfoutput>
<script type="text/javascript">
$(document).ready(function() {
	// global ids
	$pageForm = $("##contentForm");
	$pages	  = $("##pages");
	$cloneDialog = $("##cloneDialog");
	$("##pages").tablesorter();
	$("##pageFilter").keyup(function(){
		$.uiTableFilter( $pages, this.value );
	});
	// Popovers
	$(".popovers").popover({
		html : true,
		content : function(){
			return getInfoPanelContent( $(this).attr( "data-contentID" ) );
		},
		trigger : 'hover',
		placement : 'left',
		title : '<i class="icon-info-sign"></i> Quick Info',
		delay : { show: 200, hide: 500 }
	});
});

function remove(contentID){
	if( contentID != null ){
		$('##delete_'+contentID).attr('src','#prc.cbRoot#/includes/images/ajax-spinner.gif');
		$("##contentID").val( contentID );		
	}
	$pageForm.submit();
}
function getInfoPanelContent(contentID){
	return $("##infoPanel_" + contentID).html();
}
function openCloneDialog(contentID, title){
	// local id's
	var $cloneForm = $("##cloneForm");
	// open modal for cloning options
	openModal( $cloneDialog, 500, 300 );
	// form validator and data
	$cloneForm.validate({ 
		submitHandler: function(form){
           	$cloneForm.find("##cloneButtonBar").slideUp();
			$cloneForm.find("##clonerBarLoader").slideDown();
			form.submit();
        }
	});
	$cloneForm.find("##contentID").val( contentID );
	$cloneForm.find("##title").val( title ).focus();
	// close button
	$cloneForm.find("##closeButton").click(function(e){
		closeModal( $cloneDialog ); return false;
	});
	// clone button
	$cloneForm.find("##cloneButton").click(function(e){
		$cloneForm.submit();
	});
}
</script>
</cfoutput>