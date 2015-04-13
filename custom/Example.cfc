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
This custom rule compontent is a empty rule with no effects. If you want to generate own custom rule compontents,
copy this file to rules folder and implement the execute method. This is required if a rule cannot be created with the backend settings,
for example for application specific cases.
********************************************************************************/
component extends="modules.rewrites.model.Customrule" {

	// DI property, if required
	property name="controller"			inject="coldbox";
	
	Customrule function init() {
		// Init parameters
		
		// execution point: Should this compontent be execute before or after the database rules? Default: after
		// variables.executionpoint	= 'after';
		
		// Logging active for this compontent? Default: false
		// variables.activatelog		= false;
		return this;
	}
	
	
	// Implement rewrite rules here...
	void function execute() {
		// Access to event component.
		var event 	= controller.getRequestService().getContext();

		// This method should be used to execution a relocation
		// this.rewrite( event.buildLink( string newurl, numeric statuscode );
	}

}
