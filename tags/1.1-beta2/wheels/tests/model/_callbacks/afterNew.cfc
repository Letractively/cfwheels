<cfcomponent extends="wheelsMapping.test">

	<cffunction name="setup">
		<cfset loc.controller = controller(name="dummy")>
	</cffunction>

	<cffunction name="test_afterNew_valid">
		<cfset fail()>
	</cffunction>

</cfcomponent>