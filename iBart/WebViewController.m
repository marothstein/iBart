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

@synthesize webView;
@synthesize accessoryView;

@synthesize webViewLoaded;
@synthesize appDelegate;
@synthesize jsonString;

// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!appDelegate) {
        
        NSLog(@"ALL YOUR BASE ARE BELONG TO US");
        
        // Custom initialization
        appDelegate = (iBartAppDelegate *)[ [UIApplication sharedApplication] delegate];
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
	[super viewDidLoad];
    
    // subscribe to the notifications for the keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(logKeyboardAction:)
                                            name:UIKeyboardWillShowNotification
                                            object:nil];
	
//	NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithCapacity:0];

	
	// Setup the request
	NSString *htmlTemplateLink = [appDelegate bundlePathForResource:@"HPI" ofType:@"html"];
    
    
    
    NSLog( @"bundlePathForResource ----> %@", htmlTemplateLink );
	
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlTemplateLink]];
	[webView loadRequest:request];	

//	[self populateJsonAndDeliverfromDict:jsonDict];
    
    NSString *filePath = [appDelegate bundlePathForResource:@"script" ofType:@"js"];

    
    NSLog( @"----> filePath = %@", filePath );
    
    if( filePath ) {
        NSLog( @"----> filePath = %@", filePath );
        NSString *testJSContents = [NSString stringWithContentsOfFile:filePath];
        
        if( testJSContents ) {
//            NSLog( @"========> test.js contents = %@", testJSContents );
        }
    }
    
}

#pragma mark - 
#pragma mark - Debug the keyboard notifications
- (void)logKeyboardAction:(NSNotification *)notification {
    NSLog( @"KEYBOARD ACTION!!!" );
    
}

#pragma mark -
#pragma mark - Build the json

- (void)populateJsonAndDeliverfromDict:(NSDictionary *)jsonDict
{
	if (self.webViewLoaded) {
		NSString *newJsonString = [jsonDict JSONRepresentation];
		if (newJsonString != self.jsonString) {
//			self.jsonString = newJsonString;
			// execute the script
//			NSString *theScript = [NSString stringWithFormat:@"loadData(%@);", self.jsonString];	
            
			NSString *theScript = @"alert('ADSFSADFASDF');";	
			[self.webView stringByEvaluatingJavaScriptFromString:theScript];
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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight );
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[webView release];
	[jsonString release];
	[appDelegate release];
	
    [super dealloc];
}


@end
