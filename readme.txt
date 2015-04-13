/********************************************************************************
Rewrites - A module to manage rewrites by the contentbox
Copyright 2015 by Akitogo Internet And Media Applications GmbH, Frankfurt am Main, Germany
http://www.akitogo.com
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


This is the useful rewrite module to manage rewrites by the framework.
There are two different opportunities to add new rules to your application:
- use the backend interface to add/manage default rewrite rules
- use own custom rule components. See further information in folder "custom"

INSTALLATION:
Copy all files into a new module folder called "rewrites". 

If this module was activated the first time, a new database will be created called "aki_rewrites". If this not happened,
check your alter rights of your current orm datasource and restart your application.



The menu point "modules" in backend interface will be extended by an additional menu point called "Rewrites". 
Within this menu point you can add, delete and edit your default rewrite rules.

Following settings are available for all default rewrite rules:
- Title: Name your rule to identify executed rules in Logfile and also in the overview
- hosts: Regular Expression - for which hosts this rule is valid. Useful for develop/live system differences
- paths: Regular Expression - for which paths this rule is valid. If path and host was matched, rule will be executed.
- Target Type: Do you want to relocate to an existing content object in your application or a fix url?
- Target url: If "url" was selected as target type, this field is in use. If your data starts with "http", it's a relocation
directly to this url, otherwise the current host will be adopted.
- Target content: If "content" was selected as target type, module will relacate to an existing content obejct.
- Statuscode: Which status code should be used? 301 (Moved permanently) or 302 (Moved Temporarily)?
- Active: Is rule currently activated or not?
- Exeuction order: 1 is the highest priority. If there are two or more rules with the same execution order, system will executed
the rule with the lower id first.
- Logging: Should rewrites for this rules be logged?


Have fun with this module :)
