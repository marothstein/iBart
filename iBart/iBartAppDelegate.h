//
//  iBartAppDelegate.h
//  iBart
//
//  Created by Matt on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iBartViewController;

@interface iBartAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet iBartViewController *viewController;

@end
