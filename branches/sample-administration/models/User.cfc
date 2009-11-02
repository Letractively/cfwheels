<!---
	Since this model is named "User.cfc" it will by default be mapped to a table called "users" (in other words the plural version of the model name).
	Model file names are UpperCamelCase and table names are lower case so if we had a model saved as "SuperHero.cfc" for example it would be mapped to the table "superheroes".
--->

<cfcomponent extends="Model">

	<!---
		All initialization related tasks are done in the "init" function which is run the first time the model is requested.
		Below we have used some high level validation helpers, you can also use lower level validation which allows you to setup specific methods to be run on validation instead (refer to the online documentation for details).
	--->

	<cffunction name="init">

		<!---
			This validates that the "firstName" and "lastName" fields have not been left blank when filling out the edit or add forms.
			Since "message" is not passed in this will use the default Wheels error messages when displaying error information.
			As you can see it's possible to pass in multiple properties.
		--->
		<cfset validatesPresenceOf(properties="firstName,lastName")>

		<!---
			This validates that the "email" field has not been left blank.
			Here we pass in a custom error message to be displayed when the field is blank.
		--->
		<cfset validatesPresenceOf(property="email", message="You forgot to enter your email address.")>

		<!---
			This validates that the "password" field has not been left blank.
			We've been lazy here and not used named arguments since "property' is the first argument that validatesPresenceOf accepts.
		--->
		<cfset validatesPresenceOf("password")>

		<!---
			This validates that "email" is in fact a valid email address by using a regular expression.
			The "allowBlank=true" means that if "email" is blank we will NOT run this validation, that's fine since the "validatesPresenceOf" call above will catch it in this case.
			Had we set it to "false" we would show both errors (that it's blank and that it's not a valid format) to the user which may be what you want to do in some cases, it's just a matter of preference.
		--->
		<cfset validatesFormatOf(property="email", regex="^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$", allowBlank=true, message="That's not a valid email address.")>

		<!--- This validates that the "password" field fits in the "password" column in the "users" table. --->
		<cfset validatesLengthOf(property="password", allowBlank=true, maximum=20)>

		<!--- This validates that the remaining fields have the proper length as well. --->
		<cfset validatesLengthOf(properties="firstName,lastName,email", allowBlank=true, maximum=100)>

		<!--- This validates that there's not already a user in the database with the same email address. --->
		<cfset validatesUniquenessOf(property="email", message="Sorry, a user with that email address already exists.")>

	</cffunction>

</cfcomponent>