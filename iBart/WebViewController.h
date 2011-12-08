//
//  WebViewController.h
//  WebTouch
//
//  Created by Anthony Mittaz on 14/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewController.h"

@class iBartAppDelegate;

//@class InputViewController;



@interface WebViewController : UIViewController<InputViewControllerDelegate> {
	UIWebView *webView;
	InputViewController *inputViewController;
    BOOL webViewLoaded;
	iBartAppDelegate *appDelegate;
	NSString *jsonString;
    
    BOOL userIsInputting;
//    UIView *inputView;
}

@property (readwrite, retain) UIView *inputView;

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet InputViewController *inputViewController;

@property (nonatomic) BOOL webViewLoaded;
@property (nonatomic) BOOL userIsInputting;

@property (nonatomic, retain) iBartAppDelegate *appDelegate;
@property (nonatomic, copy) NSString *jsonString;

- (void)runJavascriptFunctionOnPage:(NSString *)jsString;

@end


