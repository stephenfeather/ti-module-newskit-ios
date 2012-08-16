// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
win.add(label);
win.open();

// TODO: write your module tests here
var newskit = require('com.featherdirect.newskit');
Ti.API.info("module is => " + newskit);


win.addEventListener('open', function(){
	
	newskit.addEventListener('progress', function(e){
	  	Ti.API.info("Download progress (" + e.name + ") = " + e.bytesWritten + " of " + e.totalBytes);
	});
	
	newskit.addEventListener('complete', function(e){
	  	Ti.API.info("Issue downloaded (" + e.name + ")");
	});
	
	newskit.addEventListener('error', function(e){
	  	Ti.API.info("Issue error (Code: " + e.code + ", Description: " + e.description + ")");
	});
	
	
	// We can add an issue to the NKLibrary (uniqueID, date)
	newskit.addIssue('test0001','2011-10-01');
	
	// We can get information about an issue (uniqueID)
	newskit.getIssue('test0001');
	
	// We can download the assets for an issue (uniqueID, assetURL)
	newskit.downloadAsset('test0001', 'http://data.featherdirect.com/newsstand/issue32.zip');
});

// We can remove an issue from the NKLibrary (uniqueID)
//newskit.removeIssue('test0003');




