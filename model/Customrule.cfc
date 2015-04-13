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
This compontent is used as abstract class for custom rule compontents.
All custom rule compontents have to extend this compontent.
********************************************************************************/
component singleton accessors="true" {
	
	// Logbox integration
	property name="log"			inject="logbox:logger:rewrite";
	
	// When should a custom rule component be executed related to rules stored in database? Possible values: before, after. 
	variables.executionpoint		= "after"; 
	
	// Enable logging for a specific custom rule component?
	variables.activatelog			= false;
	
	Customrule function init() {
	}
	
	// Return current execution point
	String function getExecutionPoint() {
		return variables.executionpoint;
	}
	
	// Implement rewrite rules here...
	// Empty function body to prevent not implemented function of custom rule compontents
	void function execute() {
	}
	
	// This method should be called by a custom rule compontent to execute the relocation. 
	void function rewrite( required target, required statuscode ) {
		if( variables.activatelog )
			log.info( "Rewrite detected! #cgi.request_url# was redirected to #arguments.target# with statuscode #arguments.statuscode# (Custom rule: #getMetadata().fullname#)" );
		location( arguments.target, false, arguments.statuscode );
		abort;
	}

}
