/**
 * NewsKit Titanium Module is Copyright 2012, Stephen Feather
 * Licensed under the Apache Public License (version 2)
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"
#import <NewsstandKit/NewsstandKit.h>

@interface ComFeatherdirectNewskitModule : TiModule <NSURLConnectionDownloadDelegate>

{
    NKLibrary *library;
}


@end
