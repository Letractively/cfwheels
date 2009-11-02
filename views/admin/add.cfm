<h1>Add New User</h1>
<p>Use the form below to add a new user:</p>
<cfoutput>
	<!---
		Any error messages existing on the object named "newUser" will be displayed here.
		It will be outputted as a "ul" tag with a class of "error-messages".
	--->
	#errorMessagesFor("newUser")#

	<!--- This puts a form here pointing to the "create" action in our "admin" controller. --->
	#startFormTag(action="create")#

		<!---
		Here we add fields for each column in our users table, add a submit tag and end the form.
		When there are errors on a field below it will be wrapped in a "div" tag with a class of "field-with-errors".
		We need to pass in the name of the object we have set in the controller, "newUser" in this case and also of course the name of the property.
		--->
		#textField(objectName="newUser", property="firstName", label="First Name:", labelPlacement="before")#
		#textField(objectName="newUser", property="lastName", label="Last Name:", labelPlacement="before")#
		#textField(objectName="newUser", property="email", label="Email Address:", labelPlacement="before")#
		#textField(objectName="newUser", property="password", label="Password:", labelPlacement="before")#
		#submitTag()#
	#endFormTag()#
</cfoutput>