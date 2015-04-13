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
On framework initialization load all custom rule compontents in all defined custom rule locations.
********************************************************************************/
component singleton {

	// Setting of ModuleConfig of all directories for custom rule compontents
	property name="lookup"				inject="coldbox:setting:customruleslookup@Rewrites";
	// framework to have access to wirebox
	property name="controller"			inject="coldbox";

	// Class variables
	variables.customrules	= [];
	variables.rules			= { 'before' = [], 'after' = [] };
	/**
	* Constructor	
	*/
	CustomruleAutoloader function init(){
		return this;
	}
	
	// This function is called on OnLoad in Module config. Load all custom rule components and store it.
	CustomruleAutoloader function configure() {
		var location	= '';
		var wirebox		= controller.getWirebox();
		var dirlist		= '';
		var path		= '';
		var cfc			= '';
		var index		= 1;
		
		// Register compontents to wirebox
		for( location in listToArray( lookup ) ) {
			path 		= expandPath( replaceNoCase( 'modules.rewrites.#lookup#', '.', '/', 'all' ) );
			if( directoryExists( path ) ) {
				for( cfc in directoryList( path = path, filter = '*.cfc', listinfo = 'name' ) ) {
					wirebox.getBinder().map( "rule#index#@rewrites" ).to( "modules.rewrites.#location#.#replaceNocase( cfc, '.cfc', '' )#" );
					arrayAppend( variables.customrules, "rule#index#@rewrites" );
					index++;
				}
			}
		}
		
		// Order compontents to execution point and initialize by wirebox
		for( cfc in variables.customrules ) {
			cfc	= wirebox.getInstance( cfc );
			if( cfc.getExecutionPoint() eq 'before' ) 
				arrayAppend( variables.rules.before, cfc );
			else
				arrayAppend( variables.rules.after, cfc );
			
		}
		return this;
	}
	
	// Reset all class variables to default/empty values. Called on OnUnload in Module config.
	CustomruleAutoloader function destroy() {
		variables.customrules	= [];
		variables.rules			= { 'before' = [], 'after' = [] };
		return this;
	}
	
	// public function to return all custom rule compontents before all cb rules was be executed
	public array function getCustomrulesBefore() {
		return this.getCustomRules( 'before' );
	}
	
	// public function to return all custom rule compontents after all db rules was executed.
	public array function getCustomrulesAfter() {
		return this.getCustomRules( 'after' );
	}
	
	// Search function to return all custom rule compontents to a specific execution point.
	private array function getCustomrules( required executionpoint ) {
		if( structKeyExists( variables.rules, arguments.executionpoint ) )
			return variables.rules[ arguments.executionpoint ];
			
		return [];
	}
	
	
	
}