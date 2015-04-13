<cfoutput>
<!--- Message flash box --->
#getPlugin('MessageBox').renderit()#
#html.startForm(name="pageForm", action=prc.xehSave)#
<div class="row-fluid">
	<div class="span9" id="main-content">
		<div class="box">
			<!--- Body Header --->
			<div class="header">
				<i class="icon-info-sign"></i>
				Rewrites
			</div>
			
			<!--- Body --->
			<div class="body">
				#html.hiddenField(name="id", bind=prc.entry)#
				#html.inputField(name="title",class="width98",bind=prc.entry,label='Title')#
				#html.inputField(name="host",class="width98",bind=prc.entry,label='Valid for hosts (Regex)')#
				#html.inputField(name="pattern",class="width98",bind=prc.entry,label='Valid for paths (Regex)')#
				#html.select(name="targettype",options="url,content",class="width98",bind=prc.entry,label='Target Type')#
				<!--- content id of selected content object --->
				#html.hiddenField(id="contentid",name="content",class="width98",value=prc.contentid)#
				#html.inputField(name="url",class="width98",bind=prc.entry,label='Target url (Is used if target type is set to "url")')#
				<!--- Special input line for content objects --->
				<label for="target_content" class="control-label">Target content (is used if target type is set to "content")</label>
	            <div class="controls">
	                <div class="input-prepend input-block-level">
	                    <span style="cursor: pointer" class="select-content add-on btn-info"><i class="icon-file-alt"></i></span>
	                    <input style="width: 97%" id="target_content" type="text" name="target_content" class="textfield input-block-level" title="Select a content item" readonly=true value="#prc.contenttitle#" />
	                </div>
	            </div>
				#html.select(name="statuscode", options="301,302", bind=prc.entry,label='Statuscode',class="width98")#
				<br style="clear:both;"/>		
			</div>
		</div>
	</div>
	<div class="span3" id="main-sidebar">
		<!--- Info Box --->
		<div class="small_box">
			<div class="header">
				Rule Details
			</div>
			<div class="body">
				#html.startFieldset(legend='<i class="icon-calendar"></i> Execution Settings')#
					#html.select(name="active", options="true,false", bind=prc.entry,label='Active',class="width98")#
					#html.select(name="sortorder",options="1,2,3,4,5,6,7,8,9,10", bind=prc.entry,label='Execution Order', class="width98")#
					#html.select(name="logging", options="true,false", bind=prc.entry,label='Logging',class="width98")#
					<!--- Action Bar --->
					<div class="actionBar">
						<div class="btn-group">
						&nbsp;<a class="btn" href="#prc.xehIndex#">Back</a>
						<cfif !isNull( prc.entry.getId() )>
						<a href="#prc.xehRemove#/id/#prc.entry.getId()#" class="confirmIt btn" data-title="Delete Rule?" data-message="This will delete this rewrite rule! -Are you sure?"><i id="delete_#prc.entry.getId()#" class="icon-trash icon-large"></i> Delete</a>
						</cfif>
						&nbsp;<input type="submit" class="btn btn-danger" value="Save">
						</div>
					</div>
					<!--- Loader --->
				#html.endFieldSet()#
			</div>
		</div>
		<!--- Event --->
		#announceInterception("cbadmin_pageEditorSidebarFooter")#
	</div>
	<!--- Event --->
	#announceInterception("cbadmin_pageEditorSidebarFooter")#
</div>


#html.endForm()#
</cfoutput>