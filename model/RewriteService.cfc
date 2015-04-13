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
Service to have database operation on Rewrite ORM Model
********************************************************************************/
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	// Integrate cachebox
	property name="cachebox"		inject="cachebox";

	// Constructor
	RewriteService function init(){
	
		super.init( entityName = "akiRewrites", useQueryCaching = true );
		
		// Required validation rules
		this.validationRules = { targettype		= { required = true, size = "0..10" },
								 statuscode		= { required = true, type = "numeric" },
								 sortorder		= { required = true, type = "numeric" },
								 title			= { required = true, size = "0..127" }
							};
		return this;
	}
	
	/*
	Returns all search rewrite rules incl. using cachebox.
	if active is set to false, all rewrite rules will be returned, independet of activatoin status (for cbadmin)
	if active is set to true, just all enabled rewrite rules will be returned. (for execution)
	*/
	array function getRewriteRules( active = false ) {
		var cachekey		= 'akirewrites';
		if( arguments.active )
			cachekey		= 'akirewrites-active';
		
		if( cachebox.cacheExists( 'template' ) ) 
			rewrites		= cachebox.getCache( 'template' ).get( cacheKey );

		if( isNull( rewrites ) ) {
			if( arguments.active )
				rewrites		= this.findAllWhere( criteria = { active = 1 }, sortorder = "sortorder ASC" );
			else
				rewrites		= this.getAll( sortorder = "sortorder ASC" );
			cachebox.getCache( 'template' ).set( cacheKey, rewrites );
		}
		
		return rewrites;
	}
	
	/*
	Before save, clear cache
	*/
	public function save( entity ) {
		this.clearCache();
		return super.save( arguments.entity );
	}
	
	/*
	Before delete, clear cache
	*/
	public function delete( entity ) {
		this.clearCache();
		return super.delete( arguments.entity );
	}
	
	/*
	Return validation rules for controller
	*/
	public struct function getValidationRules(){
		return this.validationRules;
	}
	
	/*
	Clear cache method
	*/
	private void function clearCache() {
		if( cachebox.cacheExists( 'template' ) ) {
			cachebox.getCache( 'template' ).clear( 'akirewrites' );
			cachebox.getCache( 'template' ).clear( 'akirewrites-active' );
		}
	}
}