//
//  WebViewController.m
//  WebTouch
//
//  Created by Anthony Mittaz on 14/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"
#import "iBartAppDelegate.h"
#import "JSON.h"

@implementation WebViewController

@synthesize webView=_webView;
@synthesize accessoryView=_accessoryView;

@synthesize webViewLoaded=_webViewLoaded;
@synthesize appDelegate=_appDelegate;
@synthesize jsonString=_jsonString;

// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        if (!self.appDelegate) {
			self.appDelegate = (iBartAppDelegate *)[[UIApplication sharedApplication]delegate];
		}
		
//        self.webView.inputAccessoryView = self.accessoryView;
		// Custom initialization
	}
		
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
	[super viewDidLoad];
    
    // subscribe to the notifications for the keyboard
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                            selector:@selector(logKeyboardAction:)
//                                            name:UIKeyboardWillShowNotification
//                                            object:nil];    
    
	self.navigationItem.title = @"iBart";
	
	NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithCapacity:0];

	
	// Setup the request
//	NSString *htmlTemplateLink = [self.appDelegate bundlePathForRessource:@"index" ofType:@"html"];
	
//	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlTemplateLink]];
//	[self.webView loadRequest:request];	

	[self populateJsonAndDeliverfromDict:jsonDict];
}

#pragma mark - 
#pragma mark - Debug the keyboard notifications
- (void)logKeyboardAction:(NSNotification *)notification {
    
}

#pragma mark -
#pragma mark - Build the json

- (void)populateJsonAndDeliverfromDict:(NSDictionary *)jsonDict
{
	if (self.webViewLoaded) {
		NSString *newJsonString = [jsonDict JSONRepresentation];
		if (newJsonString != self.jsonString) {
			self.jsonString = newJsonString;
			// execute the script
//			NSString *theScript = [NSString stringWithFormat:@"loadData(%@);", self.jsonString];	
//			[self.webView stringByEvaluatingJavaScriptFromString:theScript];
		}
	} else {
		[self performSelector:@selector(populateJsonAndDeliverfromDict:) withObject:jsonDict afterDelay:1.0];
	}
}
#pragma mark -
#pragma mark - webView delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	self.webViewLoaded = TRUE;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[_webView release];
	[_jsonString release];
	[_appDelegate release];
	
    [super dealloc];
}


@end
