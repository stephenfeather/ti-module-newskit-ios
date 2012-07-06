/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComFeatherdirectNewskitModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
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
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
    

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

-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
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
-(id)addIssue:(id)args
{
    NSString *name = [args objectAtIndex:0];
    NSString *dateStr = [args objectAtIndex:1];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    [dateFormat release];
    NKLibrary *library = [NKLibrary sharedLibrary];
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
    NSString *name = [args objectAtIndex:0];
    NKLibrary *library = [NKLibrary sharedLibrary];
    NKIssue *nkIssue = [library issueWithName:name];
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
    NSString *name = [args objectAtIndex:0];
    NKLibrary *library = [NKLibrary sharedLibrary];
    //NSLog(@"[INFO] (removeIssue) Library: %@",library);
    NKIssue *issue = [library issueWithName:name]; 
    if (issue)
    {
        [[NKLibrary sharedLibrary] removeIssue:issue];
        return @"true";
    } else {
        return @"false";
    }
}






@end
