//
//  iBartAppDelegate.h
//  iBart
//
//  Created by Matt on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"

@class iBartViewController;

@interface iBartAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    WebViewController *webViewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet WebViewController *webViewController;

- (NSString *)documentPathForFile:(NSString *)aPath;
- (NSString *)bundlePathForResource:(NSString *)aResource ofType:(NSString *)aType;


@end
