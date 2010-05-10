<cfcomponent extends="wheelsMapping.test">

	<cfinclude template="/wheelsMapping/global/functions.cfm">
	
	<cfset params = {controller="dummy", action="dummy"}>
	<cfset controller = $controller(name="dummy").$createControllerObject(params)>
	
	<cffunction name="setup">
		<cfset request.wheels["myhandle"] = {test="true"}>
	</cffunction>
	
	<cffunction name="teardown">
		<cfset structdelete(request.wheels, "myhandle", false)>
	</cffunction>

	<cffunction name="test_pagination_handle_exists">
		<cfset loc.r = controller.pagination('myhandle')>
		<cfset assert('isstruct(loc.r)')>
		<cfset assert('structkeyexists(loc.r, "test")')>
		<cfset assert('loc.r.test eq true')>
	</cffunction>

</cfcomponent>