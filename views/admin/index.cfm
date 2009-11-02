<h1>List Users</h1>
<cfif allUsers.recordCount IS 0>
	<p>There are no users in the table.</p>
<cfelse>
	<p>Here are all users (click the red "X" to delete a user).</p>
	<!--- Here we just output all the users using the query we got in the controller. --->
	<p>
		<cfoutput query="allUsers">
			<!--- Here we link to the "delete" action with a javascript confirmation alert to prevent accidental clicking. --->
			#linkTo(text="X", action="delete", key=id, confirm="Do you really want to delete #firstName#?!", style="color:red;font-weight:bold;")#
			<!--- Here we output the name and just for the fun of it we use the mailTo function to display the email address in an encoded format. --->
			#mailTo(name="#firstName# #lastName#", emailAddress=email, encode=true)#
			<br />
		</cfoutput>
	</p>
</cfif>

<!--- Let's put a link here to the "add" action so we can add more users. --->
<strong><cfoutput>#linkTo(text="Add new user..." , action="add")#</cfoutput></strong>