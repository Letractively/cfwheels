<!--- This controller is used as the public and secure interface of the application. --->
<cfcomponent extends="Controller">
	
	<cffunction name="init">
		<!--- This tells Wheels to always run the "loginRequired" function (which is located in the Controller.cfc file) for all actions except "publicContent". --->
		<cfset filters(through="loginRequired", except="publicContent")>
		
		<!--- This is useful if you want to enable access to certain roles in your application, uncomment to activate. --->
		<!--- <cfset filters(through="userProhibited")> --->
	</cffunction>

	<cffunction name="secureContent">
	</cffunction>		
	
	<cffunction name="publicContent">
	</cffunction>
	
</cfcomponent>
