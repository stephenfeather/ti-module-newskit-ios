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


### newskit.currentlyReadingIssue(uniqueID[string])

This keeps the iOS cache system from deleting the assets associated with the issue the end user may currently be viewing

	newskit.currentlyReadingIssue('test0001');



### newskit.updateIcon(imageURL[string])

This updated the icon used to display your application in the Newsstand. This should be a locally sourced image.

	newskit.updateIcon('myimage.png');

## Events

### newskit.addEventListener('progress')
This event fires as an asset is being downloaded.

	newskit.addEventListener('progress', function(e){
	  	Ti.API.info("Download progress (" + e.name + ") = " + e.bytesWritten + " of " + e.totalBytes);
	});

	// The uniqueID for our issue
	e.name

	// The size of our asset
	e.totalBytes
	
	// The number of bytes written so far
	e.bytesWritten

### newskit.addEventListener('complete')
This event fires upon completion of an asset download.

	newskit.addEventListener('complete', function(e){
	  	Ti.API.info("Issue downloaded (" + e.name + ")");
	});

	// the uniqueID for our issue
	e.name

	// The name and location of the downloaded asset
	e.contentPath

### newskit.addEventListener('error')
This even fires if there is a problem downloading an asset.

	newskit.addEventListener('error', function(e){
	  	Ti.API.info("Issue error (Code: " + e.code + ", Description: " + e.description + ")");
	});

	e.code
	e.description

## Usage

Please check the examples/app.js for the full API demonstration.

## Author

Feather Direct, LLC
Stephen Feather
stephen@featherdirect.com
@stephenfeather

## License

This module is licensed under the Apache License, Version 2.0. Please see the LICENSE file for details.
