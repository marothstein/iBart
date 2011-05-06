//
//  WebViewController.h
//  WebTouch
//
//  Created by Anthony Mittaz on 14/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iBartAppDelegate;

@interface WebViewController : UIViewController {
	UIWebView *_webView;
    UIView *_accessoryView;
	BOOL _webViewLoaded;
	iBartAppDelegate *_appDelegate;
	NSString *_jsonString;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIView *accessoryView;
@property (nonatomic) BOOL webViewLoaded;
@property (nonatomic, retain) iBartAppDelegate *appDelegate;
@property (nonatomic, copy) NSString *jsonString;

- (void)populateJsonAndDeliverfromDict:(NSDictionary *)jsonDict;

@end
