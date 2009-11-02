<!---
	Here you can add routes to your application and edit the default one.
	The default route is the one that will be called on your application's "home" page.
--->

<!--- We make the default route (a.k.a. home page) the public area so all users can access it. --->
<cfset addRoute(name="home", pattern="", controller="pages", action="publicContent")>

<!--- Create routes for login and logout so we can just refer to them that way when creating links instead of having to specify the controller and action. --->
<cfset addRoute(name="login", pattern="login", controller="sessions", action="new")>
<cfset addRoute(name="logout", pattern="logout", controller="sessions", action="delete")>