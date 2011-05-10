//
//  iBartAppDelegate.m
//  iBart
//
//  Created by Matt on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "iBartAppDelegate.h"

#import "iBartViewController.h"

@implementation iBartAppDelegate


@synthesize window=window;

@synthesize webViewController=webViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    webViewController = [ [WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    
    [window addSubview: [webViewController view] ];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark -
#pragma mark Utilities method to help find ressources from the applications directory or from the user directory:

// Permits to retrieve the path for the given file on the user documents dir
- (NSString *)documentPathForFile:(NSString *)aPath
{
    NSLog( @"----> IN documentPathForFile: \n\n");
    
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *appFile = [documentsDirectory stringByAppendingPathComponent:aPath];
	return appFile;
}

// Permits to retreive the path for the given file on the application resources dir
- (NSString *)bundlePathForResource:(NSString *)aResource ofType:(NSString *)aType
{
    
    NSLog( @"----> IN bundlePathForRessource: \n\n");
    NSLog( @"----> IN aResource: %@ \n\n", aResource );
    NSLog( @"----> IN aType: %@ \n\n", aType );
    
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *path = [bundle pathForResource:aResource ofType:aType];
	return path;
}


- (void)dealloc
{
    [window release];
    [webViewController release];
    [super dealloc];
}

@end
