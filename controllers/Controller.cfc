<!---
	This is the parent controller file that all your controllers should extend.
	You can add functions to this file to make them globally available in all your controllers.
	Do not delete this file.
--->
<cfcomponent extends="Wheels">

	<!--- This function will prevent non-logged in users from accesing specific actions. --->
	<cffunction name="loginRequired">
		<cfif NOT StructKeyExists(session, "currentUser")>
			<cfset flashInsert(info="You need to log in first!")>
			<cfset redirectTo(route="login")>
		</cfif>
	</cffunction>
	
	<!--- This function will prevent non-admin users from accesing specific actions. It could use a little more work to prevent "n" types of roles, but to keep things simple, we are only checking for "admin" users. --->
	<cffunction name="userProhibited">
		<cfif StructKeyExists(session, "currentUser") AND NOT ListFind(session.currentUser.roles, "admin")>
			<cfset flashInsert(info="You are logged in, but you can't do that!")>
			<cfset redirectTo(route="home")>
		</cfif>
	</cffunction>

</cfcomponent>