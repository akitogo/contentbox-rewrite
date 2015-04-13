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
**********


If you want to add rewrite rules to this module that cannot be declared by default behavior use the 
opportunity to create custom rule components. You can create multiple components with their own rules or every
rule can be implemented by one component.

By default, all components in folder custom.rules will be loaded. This folder is configurable within the 
module config. You can also specify multiple locations for custom rule components.

If you want to create your own custom rule component, copy Example.cfc in folder custom into custom.rules and 
rename it like you want. You've the opportunity to set the execution point, when your component will be executed 
and if you want to enable logging for just your class. Then you just have to implement the execute method with your 
own code. You can use dependency injection of coldbox to have access to your own models/services/...

