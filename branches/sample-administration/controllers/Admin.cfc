<!---
	This is the admin controller, it's the only controller in this simple application but usually you'll have many.
	It extends "Controller.cfc" which in turn extends the main Wheels framework controller, this is how all the cool Wheels functions are made available to you.
	Generally speaking the controller is responsible for getting the necessary data from the database and calling the view page (although the actual calling of the view is done by Wheels in the background most of the time unless you specifically call "renderPage" or one of the other rendering functions at the end of the action code).
--->

<cfcomponent extends="Controller">

	<!---
		The "index" action below is the one that is called from all of the following URLs:
		http://localhost/admin/index.
		http://localhost (why? because we have configured this to be the default controller/action in config/routes.cfm).
		http://localhost/admin (why? because when no action is specifically defined Wheels assumes you want to call "index").
	--->
	<cffunction name="index">
		<!---
			Here we get all the users currently in the database (it will be returned to us as a cfquery result set).
			The "model" function below returns a reference to a class (an object with no instance data stored in the application scope) on which you can call class level functions.
			the "findAll" function is a class level function (which just means that it operates on the class as a whole and not on one individual object/record).
			--->
		<cfset allUsers = model("user").findAll()>
		<!---
			How does Wheels know where to go when it reaches this place in the code?
			Well, you can call the "renderPage" function here if you want to (or any of the other rendering functions).
			If you Do NOT call "renderPage" yourself Wheels will notice this and call it for you in the background (so in this case Wheels calls "renderPage" which in turn includes the "views/admin/index.cfm" page and the "allUsers variables will be available for use in that page).
		--->
	</cffunction>

	<cffunction name="add">
		<!--- The "new" method returns an empty user object for us, this is used to make up the blank form in the view. --->
		<cfset newUser = model("user").new()>
	</cffunction>

	<cffunction name="create">
		<!--- Here we call the "new" method again but this time we fill it with the values from the form submission. --->
		<cfset newUser = model("user").new(params.newUser)>
		<!--- Let's try and save the user to the database. --->
		<cfif newUser.save()>
			<!--- The save worked so let's add a message to the "Flash" here to inform the site visitor that a change was made (the "Flash" is a session variable that only lasts from one page view to the next). --->
			<cfset flashInsert(message="User added!")>
			<!--- Redirect back to the "index" action (it's recommended to redirect after a "POST" request has been made to avoid the site visitor clicking refresh in their browser and submitting the page again). --->
			<cfset redirectTo(action="index")>
		<cfelse>
			<!--- Looks like the save failed so we simply render the view page for the "add" action again. --->
			<cfset renderPage(action="add")>
		</cfif>
	</cffunction>

	<cffunction name="delete">
		<!--- First we find the user based on the "key" in the URL. --->
		<cfset userToDelete = model("user").findByKey(params.key)>
		<!--- Now let's call the "delete" method on the user object which means the record corresponding to this object will be deleted from the table. --->
		<cfset userToDelete.delete()>
		<cfset flashInsert(message="User was deleted!")>
		<cfset redirectTo(action="index")>
	</cffunction>

</cfcomponent>