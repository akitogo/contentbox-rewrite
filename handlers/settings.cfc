/********************************************************************************
Rewrites - A module to manage rewrites by the contentbox
Copyright 2015 by Akitogo Internet And Media Applications GmbH, Frankfurt am Main, Germany
********************************************************************************
Apache License, Version 2.0

Copyright Since [2015] [Akitogo Internet And Media Applications GmbH]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
********************************************************************************/

/********************************************************************************
this handler is used by contentbox admin to administrate database rewrite rules
********************************************************************************/
component{

	// DI
	property name="service"			inject="rewriteService@rewrites";
	property name="contentService"	inject="id:contentService@cb";
	property name="cb" 				inject="cbHelper@cb";
	
	public void function preHandler( event ) {
		// Select tab
		prc.tabModules_Rewrites = true;
		
		// Store urls for required operations
		prc.xehSave		= cb.buildModuleLink( "rewrites", "settings.save" );
		prc.xehIndex	= cb.buildModuleLink( "rewrites", "settings" );
		prc.xehRemove	= cb.buildModuleLink( "rewrites", "settings.remove" );
		prc.xehEdit		= cb.buildModuleLink( "rewrites", "settings.edit" );
		prc.xehClone	= cb.buildModuleLink( "rewrites", "settings.close" );
	}
	
	// Route to display a list of all stored rewrite rules
	public void function index( event, rc, prc ) {
		prc.rewrites	= service.getRewriteRules();
		event.setView( "settings/index" );
	}

	// Route to add or edit a rewrite rule
	public void function edit( event, rc, prc ) {
		if( event.getValue( "id", 0 ) eq 0 )
			prc.entry 			= service.new();
		else
			prc.entry			= service.get( rc.id );
			
		prc.contentid 			= '';
		prc.contenttitle 		= '';
		// This is required if a rule already exists with a stored relationship to a content object.
		if( !isNull( prc.entry.getContent() ) ) {
			prc.contentid		= prc.entry.getContent().getContentId();
			prc.contenttitle	= prc.entry.getContent().getTitle();
		}
		event.setView( "settings/edit" );
	}
	
	// Route to save a rewrite rule. Validate data and store it into database. Rediret to index
	public void function save( event, rc, prc ) {
		var result = validateModel( target = rc, constraints = service.getValidationRules() );
		// Validation failed, redirect to edit page
		if( result.hasErrors() ){
			flash.put( 'preVals', rc );
			getPlugin( "MessageBox" ).setMessage( type="error", messageArray = result.getAllErrors() );
			setNextEvent( URL = cb.buildModuleLink( "rewrites", "settings.edit.id.#rc.id#" ) );
			return;
		}
		var entity	= service.new();
		if( isNumeric( rc.id ) and rc.id gt 0 )
			entity	= service.get( rc.id );
		
		if( rc.active )
			rc.active = 1;
		else
			rc.active = 0;
			
		if( rc.content eq '' ) {
			structDelete( rc, 'content' );
		} else {
			rc.content	= contentService.get( rc.content );
		} 
			
		populateModel ( entity );
		service.save( entity );
		
		getPlugin( "MessageBox" ).info( "Rewrite rule Saved!" );
		setNextEvent( URL = cb.buildModuleLink( "rewrites", "settings" ) );
	}
	
	// Route to delete an existing rewrite rule and redirect to index page
	public void function remove( event, rc, prc ) {
		var entity	= service.get( rc.id );
		service.delete( entity );
		getPlugin( "MessageBox" ).info( "Rewrite rule removed!" );
		setNextEvent( URL = cb.buildModuleLink( "rewrites", "settings" ) );
	}

}