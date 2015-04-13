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
Interceptor to execute rewrite rules before rendering starts.
********************************************************************************/
component extends="coldbox.system.Interceptor" {

	// DI
	property name="rewriteservice"	inject="rewriteService@rewrites";
	property name="autoloader"		inject="customruleAutoloader@rewrites";
	property name="cb" 				inject="cbHelper@cb";
	// Logbox integration of customized logger.
	property name="log"				inject="logbox:logger:rewrite";
	
	// Before process interception point
	public void function preProcess( event, interceptData ) {
		// Load all activated rules.
		var rules		= rewriteservice.getRewriteRules( active = true );
		var rule		= '';
		var rc			= event.getCollection( private = false );
		var customrule	= '';
		
		try {
			// Execute all custom rule components with execution point "before"
			for( customrule in autoloader.getCustomrulesBefore() ) {
				customrule.execute();
			}
			
			// Execute all db stored rewrite rules.
			for( rule in rules ) {
				if( refindNoCase( rule.getPattern(), cgi.PATH_INFO ) and refindNoCase( rule.getHost(), cgi.HTTP_HOST ) ) {
					// A rule was matched. Bulid url for redirection
					var nexturl	= rule.getUrl();
					if( rule.getTargettype() eq 'content' ) {
						if( rule.getContent().getContentType() eq 'Entry' ) {
							nexturl	= cb.linkEntry( rule.getcontent() );
							if( structKeyExists( rc, 'siteid' ) )
								nexturl	= replaceNocase( nexturl, '/akibase', '/#rc.siteid#' );
						} else {
							nexturl = event.buildLink( rule.getContent().getSlug() );
						}
					}
					if( left( nexturl, 4 ) neq 'http' ) {
						nexturl = event.buildLink( nexturl );
					}
					if( rule.getLogging() )
						log.info( "Rewrite detected! #cgi.request_url# was redirected to #nexturl# with statuscode #rule.getStatusCode()# (Default rule: #rule.getTitle()#)" );
					location( statuscode="#rule.getStatuscode()#", url="#nexturl#", addtoken="false" );
					abort;
				}
			}
			
			// Execute all custom rule compontents with execution point "after"
			for( customrule in autoloader.getCustomrulesAfter() ) {
				customrule.execute();
			}
		} catch( Any ex ) {
			// Buglog wrong in this situation cause then this module as dependencies to akibase module.
			log.error( "Error occours! #ex.message# in #ex.tagcontext[1].raw_trace#" );
		}
	}
}
