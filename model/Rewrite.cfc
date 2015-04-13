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
ORM Model for storing rewrite rules into database
********************************************************************************/
component persistent="true" entityname="akiRewrites" table="aki_Rewrites" batchsize="25" cachename="akiRewrites" cacheuse="read-write" discriminatorValue="Rewrites"{
	
	
	// Properties
	property name="id"				fieldtype="id" 	generator="native" 	setter="false";
	property name="pattern"			notnull="true" 	ormtype="string";
	property name="url"				notnull="false" ormtype="string";
	property name="content" 		notnull="false" cfc="contentbox.model.content.BaseContent" fieldtype="many-to-one" fkcolumn="FK_contentID" lazy="true" fetch="join";
	property name="targettype"		notnull="true"	ormtype="string";
	property name="statuscode"		notnull="true"	ormtype="integer";
	property name="active"			notnull="true"	ormtype="boolean";
	property name="title"			notnull="true"	ormtype="string";
	property name="host"			notnull="false"	ormtype="string";
	property name="sortorder"		notnull="true"	ormtype="integer";
	property name="logging"			notnull="true"	ormtype="boolean";
			
	/************************************** CONSTRUCTOR *********************************************/

	/**
	* constructor
	*/
	function init(){
	}
	
	/************************************** PUBLIC *********************************************/
}