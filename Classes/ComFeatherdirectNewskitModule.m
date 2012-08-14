/**
 * NewsKit Titanium Module is Copyright 2012, Stephen Feather
 * Licensed under the Apache Public License (version 2)
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComFeatherdirectNewskitModule.h"
#import "TiApp.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
//#import "ComFeatherdirectNewskitConnectionProxy.h"
#import <NewsstandKit/NewsstandKit.h>

@implementation ComFeatherdirectNewskitModule



#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"e632cf61-f749-4a04-9b82-5742edf721ca";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.featherdirect.newskit";
}

#pragma mark Lifecycle

-(void)startup
{
	
    if (![NSThread isMainThread]) {
		__block id result = nil;
		TiThreadPerformOnMainThread(^{[self loadingLibrary];}, YES);
	} else {
        [self loadingLibrary];
        
    }
    
    //[self doesNotRecognizeSelector:_cmd];
    // this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
    
   
    
    // TODO: We need to restart any paused downloads. This needs done immediately at app startup (didFinishLoadingWithParams)
    //NSUInteger count  = [library downloadingAssets].count;
    //NSLog(@"Download Count: %@", count);
    //for(NSUInteger i = 0 ; i < count ; i++)
    //{
    //    NSLog(@"We have some pending downloads");
    //    NKAssetDownload *asset = [[library downloadingAssets] objectAtIndex:i];
        
    //    [asset downloadWithDelegate: self];
        
    //}
    

}


- (void) loadingLibrary
{
    library = [NKLibrary sharedLibrary];
    
    
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

// This should be called on startup
-(void)checkForPendingDownloads:(id)args 
{
   for(NKAssetDownload *asset in [library downloadingAssets]) {
       NSLog(@"Asset to downlaod: %@",asset);
       [asset downloadWithDelegate:self];
   }
}

// This function should be able to update the app icon
-(void)updateIcon:(id)args 
{
    UIImage *newcover = [[UIImage alloc] initWithContentsOfFile:[args objectForKey:@"coverImage"]];
    [[UIApplication sharedApplication] setNewsstandIconImage:newcover];
}

// This function will set the currently reading issue (important to avoid the issue being removed from cache)
-(void)currentlyReadingIssue:(id)args 
{
    NSString *name = [args objectForKey:@"name"];
    NKIssue *nkIssue = [library issueWithName:name];
    
    [library setCurrentlyReadingIssue: nkIssue];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

}


// We can enableDevMode which removes the once per day throttle from news stand notifications
-(void)enableDevMode
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"NKDontThrottleNewsstandContentNotifications"];
    NSLog(@"[INFO] Dev Mode Enabled.");
    return;
}

// We can addIssue to the NKLibrary. Takes 2 params, unique name and date (yyyy-MM-dd)
// Returns an array of information about the issue.  If the issue is new, then newIssue is true
-(NSMutableDictionary*)addIssue:(id)args
{
    NSString *name                  = [args objectAtIndex:0];
    NSString *dateStr               = [args objectAtIndex:1];
    NSDateFormatter *dateFormat     = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    [dateFormat release];

    NKIssue *nkIssue = [library issueWithName:name];
    NSMutableDictionary *issue = [NSMutableDictionary dictionary];
    if(!nkIssue) {
        nkIssue = [library addIssueWithName:name date:date];
        [issue setObject: @"true"  forKey: @"newIssue"];
    } else {
        [issue setObject: @"false"  forKey: @"newIssue"];
    }
    
    [issue setObject: nkIssue.name  forKey: @"name"];
    [issue setObject: nkIssue.date forKey:  @"date"];
    [issue setObject: nkIssue.contentURL forKey:  @"contentURL"];
    return issue;
}

// We can getIssue from the NKLibrary. Takes 1 param, unique name
// Returns an array of information about the issue.
-(id)getIssue:(id)args
{
    NSString *name      = [args objectAtIndex:0];
    NKIssue *nkIssue    = [library issueWithName:name];
    
    NSLog(@"[INFO] (getIssue) Listing Issue: %@",nkIssue);
    NSMutableDictionary *issue = [NSMutableDictionary dictionary];
    [issue setObject: nkIssue.name  forKey: @"name"];
    [issue setObject: nkIssue.date forKey:  @"date"];
    [issue setObject: nkIssue.contentURL forKey:  @"contentURL"];
    //[issue setObject: nkIssue.assetDownloads forKey: @"assetDownloads"];
    return issue;

}

// We can removeIssue from the NKLibary. Takes 1 param, unique name
// Returns true or false
-(id)removeIssue:(id)args
{
    NSString *name = [TiUtils stringValue:args];
    NSLog(@"[INFO] (removeIssue) Library: %@",library);

    NKIssue *issue = [library issueWithName:name]; 
    if (issue)
    {
        [library removeIssue:issue];
        return @"true";
    } 
    else 
    {
        return @"false";
    }
}

/*

// We can downloadAsset and associate them with NKIssues in the NKLibrary. Takes 2 params, unique name and url
-(id)downloadAsset:(id)args
{
	NSLog(@"[DEBUG] downloadAsset");

	NSString *name = [args objectAtIndex:0];
    NSLog(@"[DEBUG] name: %@", name);
    NSString *urlStr = [args objectAtIndex:1];
    NSLog(@"[DEBUG] urlStr: %@", urlStr);
    NSURL *downloadUrl = [NSURL URLWithString: urlStr];
	NSLog(@"[DEBUG] URL: %@", downloadUrl);
    
    //NKLibrary *library = [NKLibrary sharedLibrary];
    NKIssue *nkIssue = [library issueWithName:name];
    NSLog(@"[DEBUG] nkIssue: %@", nkIssue);
    NSURLRequest *req = [NSURLRequest requestWithURL:downloadUrl];
    NSLog(@"[DEBUG] req: %@", req);
    NKAssetDownload *assetDownload = [nkIssue addAssetWithRequest:req];
    NSLog(@"[DEBUG] assetDownload: %@", assetDownload);
    [assetDownload setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys: name, @"Index", nil]];
    // let's start download
    // TODO: This is the delegate call that crashes
    [assetDownload downloadWithDelegate:self];
    [assetDownload setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:name,@"Name", nil]];

}
*/

-(id)downloadAsset:(id)args
{
    NSString *name      = [args objectAtIndex:0];
    NSString *urlStr    = [args objectAtIndex:1];
    NSURL *downloadUrl  = [NSURL URLWithString: urlStr];
    
    NKIssue *nkIssue = [library issueWithName:name];
    //NSURL *downloadURL = [publisher contentURLForIssueWithName:nkIssue.name];
    NSURL *downloadURL = [[NSURL alloc] initWithString:urlStr];
    
    if(!downloadURL) return;
    NSURLRequest *req = [NSURLRequest requestWithURL:downloadURL];
    NKAssetDownload *assetDownload = [nkIssue addAssetWithRequest:req];
    [assetDownload downloadWithDelegate:self];
    [assetDownload setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:name,@"Name", nil]];
}

#pragma mark - NSURLConnectionDownloadDelegate

-(void)updateProgressOfConnection:(NSURLConnection *)connection withTotalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes {
    // get asset
    NKAssetDownload *dnl = connection.newsstandAssetDownload;
    NSLog(@"Progress: %d", 1.f * totalBytesWritten / expectedTotalBytes);
}

-(void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes {
    [self updateProgressOfConnection:connection withTotalBytesWritten:totalBytesWritten expectedTotalBytes:expectedTotalBytes];
}

-(void)connectionDidResumeDownloading:(NSURLConnection *)connection totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes {
    NSLog(@"Resume downloading %f",1.f*totalBytesWritten/expectedTotalBytes);
    [self updateProgressOfConnection:connection withTotalBytesWritten:totalBytesWritten expectedTotalBytes:expectedTotalBytes];
}

-(void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL {
    // copy file to destination URL
    NKAssetDownload *dnl = connection.newsstandAssetDownload;
    NKIssue *nkIssue = dnl.issue;
    //NSString *contentPath = [nkIssue.contentURL path];
    NSString *contentPath = [[nkIssue.contentURL path] stringByAppendingPathComponent:@"magazine.pdf"];
    NSError *moveError=nil;
    NSLog(@"File is being copied to %@",contentPath);
    
    if([[NSFileManager defaultManager] moveItemAtPath:[destinationURL path] toPath:contentPath error:&moveError]==NO) {
        NSLog(@"Error copying file from %@ to %@",destinationURL,contentPath);
    }
    
}

@end
