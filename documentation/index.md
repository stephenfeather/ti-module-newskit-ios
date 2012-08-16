# newskit Module

## Description

This is a module to wrap the Apple Newsstand API for use in a Titanium IOS project.

## Accessing the newskit Module

To access this module from JavaScript, you would do the following:

	var newskit = require("com.featherdirect.newskit");

The newskit variable is a reference to the Module object.	

## Reference


### newskit.addIssue(uniqueID[string], issueDate[string])

Adds an issue to the Newsstand Library.  The uniqueID is used to track the issue throughout the Newsstand API.

	var myVariable = newskit.addIssue('test001','2011-10-01');

	// The uniqueID you passed to the library on creation
	myVariable.name 

	// The unique path assigned to this issue by the library
	myVariable.contentURL

	myVariable.newIssue

	// The date assigned to the issue upon creation
	myVariable.date 

### newskit.removeIssue(uniqueID[string])

Removes an issue from the Newsstand Library.  

### newskit.getIssue(uniqueID[string])

This returns the information about a particular issue.

	var myVariable = newskit.getIssue('test001');

	// The uniqueID you passed to the library on creation
	myVariable.name 

	// The unique path assigned to this issue by the library
	myVariable.contentURL

	myVariable.newIssue

	// The date assigned to the issue upon creation
	myVariable.date 

### newskit.downloadAsset(uniqueID[string], assetToDownloadURL[string]);

This associated a downloadAsset in the library with the issue we have already added.  The library will attempt to download the asset immediately if not constrained bt system restrictions. Should the download be paused, it will be resumed when the application restarts.

	newskit.downloadAsset('test0001', 'http://data.mydomain.com/com.mypublication.test0001/test0001.zip');


### ___PROJECTNAMEASIDENTIFIER__.property

TODO: This is an example of a module property.

## Usage

Best to refer to the app.js for example usage

## Author

Feather Direct, LLC
Stephen Feather
stephen@featherdirect.com
@stephenfeather

## License

TODO: Enter your license/legal information here.
