<cffunction name="styleSheetLinkTag" returntype="string" access="public" output="false" hint="Returns a `link` tag for a stylesheet (or several) based on the supplied arguments."
	examples=
	'
		<!--- view code --->
		<head>
		    ##styleSheetLinkTag("styles")##
		</head>
	'
	categories="view-helper,assets" chapters="miscellaneous-helpers" functions="javaScriptIncludeTag,imageTag">
	<cfargument name="sources" type="string" required="false" default="" hint="The name of one or many CSS files in the `stylesheets` folder, minus the `.css` extension. (Can also be called with the `source` argument).">
	<cfargument name="type" type="string" required="false" hint="The `type` attribute for the `link` tag.">
	<cfargument name="media" type="string" required="false" hint="The `media` attribute for the `link` tag.">
	<cfargument name="head" type="string" required="false" hint="Set to `true` to place the output in the `head` area of the HTML page instead of the default behavior which is to place the output where the function is called from.">
	<cfargument name="host" type="string" required="false" hint="See documentation for @URLFor">
	<cfargument name="protocol" type="string" required="false" hint="See documentation for @URLFor">
	<cfargument name="port" type="numeric" required="false" hint="See documentation for @URLFor">
	<cfscript>
		var loc = {};
		loc.returnValue = "";
		$combineArguments(args=arguments, combine="sources,source", required=true);
		$insertDefaults(name="styleSheetLinkTag", reserved="href,rel", input=arguments);
		arguments.sources = $listClean(list="#arguments.sources#", returnAs="array");
		arguments.rel = "stylesheet";
		loc.CSSPath = application.wheels.webPath & application.wheels.stylesheetPath;
		if(StructKeyExists(arguments, "host") || StructKeyExists(arguments, "protocol") || StructKeyExists(arguments, "port"))
		{	
			arguments.onlyPath = false;
			loc.CSSPath = URLFor(argumentCollection=arguments);
			StructDelete(arguments, "onlyPath", false);
		}
		StructDelete(arguments, "host", false);
		StructDelete(arguments, "protocol", false);
		StructDelete(arguments, "port", false);
		if(Right(loc.CSSPath, 1) neq "/")
		{
			loc.CSSPath &= "/";
		}
		loc.iEnd = ArrayLen(arguments.sources);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
		{
			loc.item = arguments.sources[loc.i];
			if (!ListFindNoCase("css,cfm", ListLast(loc.item, ".")))
			{
				loc.item &= ".css";
			}
			arguments.href = loc.CSSPath & loc.item;
			arguments.href = $assetDomain(arguments.href) & $appendQueryString();
			loc.returnValue = loc.returnValue & $tag(name="link", skip="sources,head", close=true, attributes=arguments) & chr(10);
		}
		if (arguments.head)
		{
			$htmlhead(text=loc.returnValue);
			loc.returnValue = "";
		}
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="javaScriptIncludeTag" returntype="string" access="public" output="false" hint="Returns a `script` tag for a Javascript file (or several) tag based on the supplied arguments."
	examples=
	'
		<!--- view code --->
		<head>
		    ##javaScriptIncludeTag("main")##
		</head>
	'
	categories="view-helper,assets" chapters="miscellaneous-helpers" functions="styleSheetLinkTag,imageTag">
	<cfargument name="sources" type="string" required="false" default="" hint="The name of one or many JavaScript files in the `javascripts` folder, minus the `.js` extension. (Can also be called with the `source` argument).">
	<cfargument name="type" type="string" required="false" hint="The `type` attribute for the `script` tag.">
	<cfargument name="head" type="string" required="false" hint="See documentation for @styleSheetLinkTag.">
	<cfargument name="host" type="string" required="false" hint="See documentation for @URLFor">
	<cfargument name="protocol" type="string" required="false" hint="See documentation for @URLFor">
	<cfargument name="port" type="numeric" required="false" hint="See documentation for @URLFor">
	<cfscript>
		var loc = {};
		loc.returnValue = "";
		$combineArguments(args=arguments, combine="sources,source", required=true);
		$insertDefaults(name="javaScriptIncludeTag", reserved="src", input=arguments);
		arguments.sources = $listClean(list="#arguments.sources#", returnAs="array");
		loc.JSPath = application.wheels.webPath & application.wheels.javascriptPath;
		if(StructKeyExists(arguments, "host") || StructKeyExists(arguments, "protocol") || StructKeyExists(arguments, "port"))
		{	
			arguments.onlyPath = false;
			loc.JSPath = URLFor(argumentCollection=arguments);
			StructDelete(arguments, "onlyPath", false);
		}
		StructDelete(arguments, "host", false);
		StructDelete(arguments, "protocol", false);
		StructDelete(arguments, "port", false);
		if(Right(loc.JSPath, 1) neq "/")
		{
			loc.JSPath &= "/";
		}
		loc.iEnd = ArrayLen(arguments.sources);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
		{
			loc.item = arguments.sources[loc.i];
			if (!ListFindNoCase("js,cfm", ListLast(loc.item, ".")))
			{
				loc.item &= ".js";
			}
			arguments.src = loc.JSPath & loc.item;
			arguments.src = $assetDomain(arguments.src) & $appendQueryString();
			loc.returnValue = loc.returnValue & $element(name="script", skip="sources,head", attributes=arguments) & chr(10);
		}
		if (arguments.head)
		{
			$htmlhead(text=loc.returnValue);
			loc.returnValue = "";
		}
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="imageTag" returntype="string" access="public" output="false" hint="Returns an `img` tag and will (if the image is stored in the local `images` folder) set the `width`, `height`, and `alt` attributes automatically for you."
	examples=
	'
		##imageTag("logo.png")##
	'
	categories="view-helper,assets" chapters="miscellaneous-helpers" functions="javaScriptIncludeTag,styleSheetLinkTag">
	<cfargument name="source" type="string" required="true" hint="The file name of the image if it's availabe in the local file system (i.e. ColdFusion will be able to access it). Provide the full URL if the image is on a remote server.">
	<cfscript>
		var loc = {};
		$insertDefaults(name="imageTag", reserved="src", input=arguments);
		if (application.wheels.cacheImages)
		{
			loc.category = "image";
			loc.key = $hashStruct(arguments);
			loc.lockName = loc.category & loc.key;
			loc.conditionArgs = {};
			loc.conditionArgs.category = loc.category;
			loc.conditionArgs.key = loc.key;
			loc.executeArgs = arguments;
			loc.executeArgs.category = loc.category;
			loc.executeArgs.key = loc.key;
			if (StructKeyExists(arguments, "id"))
				loc.executeArgs.wheelsId = arguments.id; // ugly fix due to the fact that id can't be passed along to cfinvoke
			loc.returnValue = $doubleCheckedLock(name=loc.lockName, condition="$getFromCache", execute="$addImageTagToCache", conditionArgs=loc.conditionArgs, executeArgs=loc.executeArgs);
			if (StructKeyExists(arguments, "id"))
				loc.returnValue = ReplaceNoCase(loc.returnValue, "wheelsId", "id"); // ugly fix, see above
		}
		else
		{
			loc.returnValue = $imageTag(argumentCollection=arguments);
		}
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="$addImageTagToCache" returntype="string" access="public" output="false">
	<cfscript>
		var returnValue = "";
		returnValue = $imageTag(argumentCollection=arguments);
		$addToCache(key=arguments.key, value=returnValue, category=arguments.category);
	</cfscript>
	<cfreturn returnValue>
</cffunction>

<cffunction name="$imageTag" returntype="string" access="public" output="false">
	<cfscript>
		var loc = {};
		loc.localFile = true;

		if(Left(arguments.source, 7) == "http://" || Left(arguments.source, 8) == "https://")
			loc.localFile = false;

		if (!loc.localFile)
		{
			arguments.src = arguments.source;
		}
		else
		{
			arguments.src = application.wheels.webPath & application.wheels.imagePath & "/" & arguments.source;
			if (application.wheels.showErrorInformation)
			{
				if (loc.localFile && !FileExists(ExpandPath(arguments.src)))
					$throw(type="Wheels.ImageFileNotFound", message="Wheels could not find `#expandPath('#arguments.src#')#` on the local file system.", extendedInfo="Pass in a correct relative path from the `images` folder to an image.");
				else if (!ListFindNoCase(GetReadableImageFormats(),ListLast(arguments.source,".")))
					$throw(type="Wheels.ImageFormatNotSupported", message="Wheels can't read image files with that format.", extendedInfo="Use one of these image types instead: #GetReadableImageFormats()#.");
			}
			// height and/or width arguments are missing so use cfimage to get them
			if (!StructKeyExists(arguments, "width") or !StructKeyExists(arguments, "height"))
			{
				loc.image = $image(action="info", source=ExpandPath(arguments.src));
				if (!StructKeyExists(arguments, "width") and loc.image.width gt 0)
					arguments.width = loc.image.width;
				if (!StructKeyExists(arguments, "height") and loc.image.height gt 0)
					arguments.height = loc.image.height;
			}
			// only append a query string if the file is local
			arguments.src = $assetDomain(arguments.src) & $appendQueryString();
		}
		if (!StructKeyExists(arguments, "alt"))
			arguments.alt = capitalize(ReplaceList(SpanExcluding(Reverse(SpanExcluding(Reverse(arguments.src), "/")), "."), "-,_", " , "));
		loc.returnValue = $tag(name="img", skip="source,key,category", close=true, attributes=arguments);
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="$appendQueryString" returntype="string" access="public" output="false">
	<cfscript>
		var returnValue = "";
		// if assetQueryString is a boolean value, it means we just reloaded, so create a new query string based off of now
		// the only problem with this is if the app doesn't get used a lot and the application is left alone for a period longer than the application scope is allowed to exist
		if (IsBoolean(application.wheels.assetQueryString) and YesNoFormat(application.wheels.assetQueryString) == "no")
			return returnValue;

		if (!IsNumeric(application.wheels.assetQueryString) and IsBoolean(application.wheels.assetQueryString))
			application.wheels.assetQueryString = Hash(DateFormat(Now(), "yyyymmdd") & TimeFormat(Now(), "HHmmss"));
		returnValue = returnValue & "?" & application.wheels.assetQueryString;
	</cfscript>
	<cfreturn returnValue />
</cffunction>

<cffunction name="$assetDomain" returntype="string" access="public" output="false">
	<cfargument name="pathToAsset" type="string" required="true">
	<cfscript>
		var loc = {};
		loc.returnValue = arguments.pathToAsset;
		if (application.wheels.showErrorInformation)
		{
			if (!IsStruct(application.wheels.assetPaths) && !IsBoolean(application.wheels.assetPaths))
				$throw(type="Wheels.IncorrectConfiguration", message="The setting `assetsPaths` must be false or a struct.");
			if (IsStruct(application.wheels.assetPaths) && !ListFindNoCase(StructKeyList(application.wheels.assetPaths), "http"))
				$throw(type="Wheels.IncorrectConfiguration", message="The `assetPaths` setting struct must contain the key `http`");
		}

		// return nothing if assetPaths is not a struct
		if (!IsStruct(application.wheels.assetPaths))
			return loc.returnValue;

		loc.protocol = "http://";
		loc.domainList = application.wheels.assetPaths.http;

		if (isSecure())
		{
			loc.protocol = "https://";
			if (StructKeyExists(application.wheels.assetPaths, "https"))
				loc.domainList = application.wheels.assetPaths.https;
		}

		loc.domainLen = ListLen(loc.domainList);

		if (loc.domainLen gt 1)
		{
			// now comes the interesting part, lets take the pathToAsset argument, hash it and create a number from it
			// so that we can do mod based off the length of the domain list
			// this is an easy way to apply the same sub-domain to each asset, so we do not create more work for the server
			// at the same time we are getting a very random hash value to rotate the domains over the assets evenly
			loc.pathNumber = Right(REReplace(Hash(arguments.pathToAsset), "[A-Za-z]", "", "all"), 5);

			loc.position = (loc.pathNumber mod (loc.domainLen)) + 1;
		}
		else
		{
			loc.position = loc.domainLen;
		}
		loc.returnValue = loc.protocol & Trim(ListGetAt(loc.domainList, loc.position)) & arguments.pathToAsset;
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>
