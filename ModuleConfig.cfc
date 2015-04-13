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


component hint="Rewrites Module"{

	// Module Properties
	this.title 				= "Rewrites";
	this.author 			= "Matthias Richter";
	this.webURL 			= "http://www.akitogo.com";
	this.description 		= "";
	this.version			= "1.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "rewrites";


	//------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------
	function configure() {
	
		// parent settings
		parentSettings = {};

		// module settings - stored in modules.name.settings
		// directory for custom rule components. All cfc's will be loaded automatically
		settings = {
			customruleslookup	= 'custom.rules'// comma-separeted list
			
		};
		
		// Layout Settings
		layoutSettings = {
			defaultLayout = ""
		};

		// datasources
		datasources = {};

		// web services
		webservices = {};

		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="home",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Custom Declared Points
		interceptorSettings = {
		};

		// Custom Declared Interceptors
		interceptors = [
			{class="#moduleMapping#.interceptors.rewrites", name="rewrites@rewrites"}
		];
		
		// Add new category and appender to logbox
		var config	= logbox.getConfig();
		config.appender( name = "rewriteAppender", class = "coldbox.system.logging.appenders.CFAppender", properties = { fileName = "rewrite.log" } );
		config.category( name = "rewrite", appenders = "rewriteAppender" );
		logbox.configure( config );
		
		// Bind required compontents to wirebox
		binder.map( "rewriteService@rewrites" ).to( "#moduleMapping#.model.rewriteService" );
		binder.map( "customruleAutoloader@rewrites" ).to( "#moduleMapping#.model.CustomruleAutoloader" );
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is registered and activated.
	//------------------------------------------------------------------------------------------------
	function onLoad() {
		// Autoloader of custom rule components
		controller.getWirebox().getInstance( "customruleAutoloader@rewrites" ).configure();
		// Let's add ourselves to the main menu in the Modules section
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
		// Add Menu Contribution
		menuService.addSubMenu(topMenu = menuService.MODULES, name = "Rewrites", label = "Rewrites", href = "#menuService.buildModuleLink('rewrites','settings')#");
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is activated by ContentBox
	//------------------------------------------------------------------------------------------------
	function onActivate() {
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is unregistered and unloaded
	//------------------------------------------------------------------------------------------------
	function onUnload() {
		// Deactivate custom rule compontents
		controller.getWirebox().getInstance( "customruleAutoloader@rewrites" ).destroy();
		// Let's remove ourselves to the main menu in the Modules section
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
		// Remove Menu Contribution
		menuService.removeSubMenu(topMenu = menuService.MODULES, name = "Rewrites");
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is deactivated by ContentBox
	//------------------------------------------------------------------------------------------------
	function onDeactivate() {
	}

}