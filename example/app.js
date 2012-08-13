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

// We can enableDevMode which removes the Newsstand Notifications Throttle
//newskit.enableDevMode;

// We can add an issue to the NKLibrary (uniqueID, date)
//newskit.addIssue('test0001','2011-10-01');

// We can get information about an issue (uniqueID)
//newskit.getIssue('test0002');

// We can download the assets for an issue (uniqueID, assetURL)
//newskit.downloadAsset('test0003', 'http://data.featherdirect.com/newsstand/issue32.zip');

// We can remove and issue from the NKLibrary (uniqueID)
//newskit.removeIssue('test0003');




