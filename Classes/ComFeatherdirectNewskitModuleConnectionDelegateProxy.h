//
//  ConnectionDelegate.h
//  newskit
//
//  Created by Stephen Feather on 8/5/12.
//
//

#import "TiProxy.h"

@interface ComFeatherdirectNewskitModuleConnectionDelegateProxy : TiProxy <NSURLConnectionDelegate>
{
    NSURLConnection *myconnection;

}
@end
