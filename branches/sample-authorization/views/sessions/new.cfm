<h1>Login</h1>
<p>Enter username and password below to log in.</p>

<cfoutput>
	#startFormTag(action="create")#
		#textFieldTag(name="login", label="Username:", labelPlacement="before")#
		#passwordFieldTag(name="password", label="Password:", labelPlacement="before")#
		#submitTag(value="Login")#
	#endFormTag()#
</cfoutput>