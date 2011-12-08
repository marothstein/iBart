//
//  WebViewController.m
//  WebTouch
//
//  Created by Anthony Mittaz on 14/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"

#import "InputViewController.h"
#import "iBartAppDelegate.h"
#import "JSON.h"

@implementation WebViewController

@synthesize webView;
@synthesize inputViewController;

@synthesize webViewLoaded;
@synthesize appDelegate;
@synthesize jsonString;

@synthesize inputView;

@synthesize userIsInputting;

// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!appDelegate) {
        
        NSLog(@"ALL YOUR BASE ARE BELONG TO US");
        
        // Custom initialization
        appDelegate = (iBartAppDelegate *)[ [UIApplication sharedApplication] delegate];
        
        if( inputViewController == nil ) {
            inputViewController = [[InputViewController alloc] initWithNibName:@"InputViewController" bundle:nil];
            inputViewController.delegate = self;
        }
        inputView = [inputViewController view];

        // start this as false
        userIsInputting = NO;
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
	[super viewDidLoad];
    
    // subscribe to the notifications for the keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(keyboardWillShow:)
                                            name:UIKeyboardWillShowNotification
                                            object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShowed:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

	
	// Setup the request
	NSString *htmlTemplateLink = [appDelegate bundlePathForResource:@"HPI" ofType:@"html"];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlTemplateLink]];
	[webView loadRequest:request];	    
}


#pragma mark - 
#pragma mark - Debug the keyboard notifications
- (void)keyboardShowed:(NSNotification *)notification {
    
    // only respond if the user is not already inputting
    if( userIsInputting == NO )
    {
        userIsInputting = YES;
        
        NSLog( @"KEYBOARD SHOWED" );

        NSString *currentText = [webView stringByEvaluatingJavaScriptFromString:@"getCurrentText();"];
        NSLog( @"current text = %@", currentText );
        
        NSString *currentFieldTitle = [webView stringByEvaluatingJavaScriptFromString:@"getCurrentFieldTitle();"];
        NSLog( @"current field title = %@", currentFieldTitle );
        
        [inputViewController setText:currentText];
        [inputViewController setFieldNameLabelText:currentFieldTitle];
        [self presentModalViewController: inputViewController animated: YES];
    }
    
}

#pragma mark - 
#pragma mark - Debug the keyboard notifications
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSLog( @"KEYBOARD IS COMING!!!" );
}

#pragma mark -
#pragma mark - Run the js method

- (void)runJavascriptFunctionOnPage:(NSString *)jsString
{
	if (self.webViewLoaded) {
//        NSString *theScript = @"alert('ADSFSADFASDF');";	
        
        NSLog( @"----> loaded and RUNNING" );
        NSString *returnString = [self.webView stringByEvaluatingJavaScriptFromString:jsString];
        
        NSLog( @"=======> returned value = %@", returnString );
	} else {
        
        NSLog( @"----> webView not loaded yet... waiting and trying again... ");
		[self performSelector:@selector(runJavascriptFunctionOnPage:) withObject:jsString afterDelay:1.0];
	}
}

#pragma mark -
#pragma mark - webView delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSLog( @"webView has finished loading!!!" );
	self.webViewLoaded = TRUE;
}

#pragma mark -
#pragma mark - InputViewController delegate
- (void) finishInputAndPassBackText: (NSString *) text 
{
    NSLog( @" -------> input view finished!!!" );
    NSLog( @" -------> TEXT PASSED BACK: %@", text );
    
    // scroll back down
    [webView stringByEvaluatingJavaScriptFromString:@"scroll(0,0);"];
    
    // dismiss the inputview
    [self dismissModalViewControllerAnimated:YES];
    
    // declare that user is no longer inputting
    userIsInputting = NO;
    
    // fix the text
    NSArray* newLineChars = [NSArray arrayWithObjects:@"\\u000A", @"\\u000B",@"\\u000C",@"\\u000D",@"\\u0085",nil];
    
    for( NSString* nl in newLineChars )
        text = [text stringByReplacingOccurrencesOfString: nl withString:@""];
    
    NSString *jsString = [[NSString alloc] initWithString:@"commitText( \""];
    jsString = [jsString stringByAppendingString:text];
    jsString = [jsString stringByAppendingString:@"\" );"];
    
    NSLog( @"trying to run: %@", jsString);
    // push the text into the currently selected textfield
    [self runJavascriptFunctionOnPage:[[NSString alloc] initWithString:jsString]];
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
    [inputViewController release];
	[webView release];
	[jsonString release];
	[appDelegate release];
	
    [super dealloc];
}


@end
