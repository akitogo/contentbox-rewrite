<cfoutput>
<div class="row-fluid">
	<!--- main content --->
	<div class="span9" id="main-content">
		<div class="box">
			<!--- Body Header --->
			<div class="header">
				<!---<i class="icon-file-alt icon-large"></i>--->
				Rewrites
			</div>
			<!--- Body --->
			<div class="body">	
			
				<!--- messageBox --->
				#getPlugin("MessageBox").renderit()#
				
				<!--- Info --->
				<p>
					Manage your application rewrites
				</p>
				
				<!--- entryForm --->
				
				<!--- Content Bar --->
				<div class="well well-small text-right" id="contentBar">
					<!--- Create Butons --->
					<button class="btn btn-danger" onclick="return to('#prc.xehEdit#');">Create Rewrite</button>
				</div>
				
				<table name="pages" id="pages" class="tablesorter table table-striped table-hover" width="98%"> 
					<thead>
						<tr>
							<th>Order</th>
							<th>Title</th>
							<th>Host</th>
							<th>Path</th>
							<th>Target</th>
							<th width="40" class="center"><i class="icon-globe icon-large" title="Active"></i></th>
							<th width="90" class="center {sorter:false}">Actions</th>
						</tr>
					</thead>
					<tbody>
						<cfloop array="#prc.rewrites#" index="entry">
						<tr>
							<td>
								#entry.getSortorder()#
							</td>
							<td>
								<a href="#prc.xehEdit#/id/#entry.getId()#">#entry.getTitle()#</a>
							</td>
							<td>
								#entry.getHost()#
							</td>
							<td>
								#entry.getPattern()#
							</td>
							<td>
								<cfif entry.getTargettype() eq 'url'>
									URL: #entry.getUrl()#
								<cfelse>
									#entry.getContent().getContentType()#: #entry.getContent().getTitle()#
								</cfif>
							</td>												
							<td class="center">
								<cfif entry.getActive()>
									<i class="icon-ok icon-large textGreen" title="Page Published"></i>
									<span class="hidden">published in future</span>
								<cfelse>
									<i class="icon-remove icon-large textRed" title="Rewrite not active"></i>
									<span class="hidden">inactive</span>
								</cfif>
							</td>
							<td class="center">
								<!--- Actions --->
								<div class="btn-group">
							    	<a class="btn dropdown-toggle" data-toggle="dropdown" href="##" title="Actions">
										<i class="icon-cogs icon-large"></i>
									</a>
							    	<ul class="dropdown-menu text-left">
										<!--- Clone Command --->
										<!---<li><a href="javascript:openCloneDialog('#entry.getId()#','#URLEncodedFormat(entry.getPattern())#')"><i class="icon-copy icon-large"></i> Clone</a></li>--->
										<!--- Delete Command --->
										<li><a href="#prc.xehRemove#/id/#entry.getId()#" class="confirmIt"
										  data-title="Delete Rule?" data-message="This will delete this rewrite rule! -Are you sure?"><i id="delete_#entry.getId()#" class="icon-trash icon-large"></i> Delete</a></li>
										<!--- Edit Command --->
										<li><a href="#prc.xehEdit#/id/#entry.getId()#"><i class="icon-info-sign"></i> Edit</a></li>
							    	</ul>
							    </div>								
							</td>
						</tr>
						</cfloop>
					</tbody>
				</table>
				
			</div>
		</div>
	</div>
	
	<!--- main sidebar --->
	<div class="span3" id="main-sidebar">
		<!--- Saerch Box --->
		<div class="small_box">
		</div>

	</div>
</div>
<!--- Clone Dialog --->
<cfif prc.oAuthor.checkPermission("PAGES_EDITOR") OR prc.oAuthor.checkPermission("PAGES_ADMIN")>
<div id="cloneDialog" class="modal hide fade">
	<div id="modalContent">
	    <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h3><i class="icon-copy"></i> Page Cloning</h3>
	    </div>
        #html.startForm(name="cloneForm", action=prc.xehClone, class="form-vertical")#
        <div class="modal-body">
			<p>By default, all internal page links are updated for you as part of the cloning process.</p>
		
			#html.hiddenField(name="id")#
			#html.textfield(name="title", label="Please enter the new page title:", class="input-block-level", required="required", size="50",wrapper="div class=controls",labelClass="control-label",groupWrapper="div class=control-group")#
			<label for="pageStatus">Publish new object?</label>
			<small>By default all cloned themes are published as drafts.</small><br>
			#html.select(options="true,false", name="pageStatus", selectedValue="false", class="input-block-level",wrapper="div class=controls",labelClass="control-label",groupWrapper="div class=control-group")#
			<!---Notice --->
			<div class="alert alert-info">
				<i class="icon-info-sign icon-large"></i> Please note that cloning is an expensive process, so please be patient when cloning big hierarchical content trees.
			</div>
		</div>
        <div class="modal-footer">
            <!--- Button Bar --->
        	<div id="cloneButtonBar">
          		<button class="btn" id="closeButton"> Cancel </button>
          		<button class="btn btn-danger" id="cloneButton"> Clone </button>
            </div>
			<!--- Loader --->
			<div class="center loaders" id="clonerBarLoader">
				<i class="icon-spinner icon-spin icon-large icon-2x"></i>
				<br>Please wait, doing some hardcore cloning action...
			</div>
        </div>
		#html.endForm()#
	</div>
</div>
</cfif>	
</cfoutput>