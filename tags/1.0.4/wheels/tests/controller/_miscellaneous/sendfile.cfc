<cfcomponent extends="wheelsMapping.test">

	<cfset global.controller = createobject("component", "wheelsMapping.controller") />
	
	<cffunction name="test_sendFile_valid">
		<!--- not sure how we are going to test this when the end point is to deliver a file --->
		<cfset fail()>
	</cffunction>
	
</cfcomponent>