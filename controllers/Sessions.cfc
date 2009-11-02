<!--- This is where the magic happens. A whole new controller has been created to handle the authentification of users. Although adding this into a "Users" controller would perhaps be easier to learn, it is a good idea to keep your controllers as simple and self-contained as possible. --->
<cfcomponent extends="controller">
	
	<!--- The login form. --->
	<cffunction name="new">
	</cffunction>
	
	<!--- Initiates the authentification process. --->
	<cffunction name="create">
		<cfif params.login is "" or params.password is "">
			<cfset failedLogin()>
		<cfelse>
			<cfset passwordAuthentication(params.login, params.password)>
		</cfif>
	</cffunction>
	
	<!--- "Logout" feature. --->
	<cffunction name="delete">
		<cfset StructDelete(session, "currentUser")>
		<cfset flashInsert(info="You have been logged out")>
		<cfset redirectTo(route="home")>
	</cffunction>
	
	<!--- private functions. --->
	
	<cffunction name="passwordAuthentication" access="private">
		<cfargument name="login" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		
		<!--- Since "authUser" is not meant to be displayed in the view we var scope it so that it never leaks out of this function. ---> 
		<cfset var authUser = {}>
		
		<!--- Check the credential, this of course should be done against a "User" model but for demo purposes we are keeping things simple here. --->
		<cfif arguments.login IS "admin" AND arguments.password IS "1234">
			
			<!--- If everything was ok, create the "user" session --->
			<cfset authUser.login = "admin">
			<cfset authUser.password = "1234">
			<cfset authUser.roles = "user">
			
			<!--- Store it into the "session" scope. --->
			<cfset session.currentUser = Duplicate(authUser)>
			
			<!--- Redirect to the secure page (or any other page that you wish). --->
			<cfset redirectTo(controller="pages", action="secureContent")>

		<cfelse>

			<cfset failedLogin()>

		</cfif>

	</cffunction>
	
	<!--- If the logged in failed, run this --->
	<cffunction name="failedLogin" access="private">
		<cfset flashInsert(info="Login failed, please try again")>
		<cfset redirectTo(action="new")>
	</cffunction>
	
</cfcomponent>