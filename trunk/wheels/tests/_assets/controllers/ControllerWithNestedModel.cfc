<cfcomponent extends="wheelsMapping.controller">

	<cfset author = model("author").findOne(where="lastname = 'Djurner'", include="profile")>
	<cfset author.posts = author.posts(include="comments", returnAs="objects")>

</cfcomponent>