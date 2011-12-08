//
//  InputViewController.m
//  iBart
//
//  Created by Matt on 5/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InputViewController.h"

@implementation InputViewController

@synthesize textView;
@synthesize fieldNameLabel;
@synthesize vuiController;
@synthesize recordingNow;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil 
                           bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if( textView == nil ) {
            
            NSLog( @"(INPUTVIEWCONTROLLER - init) =====> textView was null.... ");
            textView = [[UITextView alloc] init];
        }
        
        if( fieldNameLabel == nil ) {
            
            NSLog( @"(INPUTVIEWCONTROLLER - init) =====> fieldNameLabel was null.... ");
            fieldNameLabel = [[UILabel alloc] init];
        }

    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
    @try {
        NSLog( @"------> TRYING TO LOAD THE VUICONTROLLER" );
        
        // assign VUI Controller
        NUSAVuiController* ourVuiController = [[NUSAVuiController alloc] initWithView: [self view]]; 
        self.vuiController = ourVuiController; 
        
        //        [ourVuiController release]; 
        
        [[NUSASession sharedSession] setDelegate: self]; 
        
        NSLog( @"------> LOADING THE VUICONTROLLER WAS SUCCESSFUL" );
    }
    @catch ( NSException *exception ) {
        NSLog( @"===========>Exception thrown: %@", [exception name]);
        NSLog( @"===========>Exception reason: %@", [exception reason]);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)setText:(NSString *)text
{
    if( textView == nil ) {
        
        NSLog( @"(INPUTVIEWCONTROLLER) =====> textView was null.... ");
        textView = [[UITextView alloc] init];
    }
    
    [textView setText:text];
    
    // just in case we lost first responder
    [textView becomeFirstResponder];
    
}

- (void)setFieldNameLabelText:(NSString *)fieldName 
{
    if( fieldNameLabel == nil ) {
        
        NSLog( @"(INPUTVIEWCONTROLLER) =====> fieldNameLabel was null.... ");
        fieldNameLabel = [[UILabel alloc] init];
    }
    
    [fieldNameLabel setText:fieldName];
}

#pragma mark -
#pragma mark Action messages 

- (void) doneAction:(id)sender {
    NSLog(@" DONE ACTION PRESSED ");
    
    [[self delegate] finishInputAndPassBackText:[textView text]];
}

- (void) toggleRecordingAction: (id) sender {
    
    NSLog( @"----> TOGGLE RECORDING ACTION" );
	// Implement a simple toggle recording method. For simplicities sake, we use the current title 
	// of the record toggle button to decide which NUSASession method to call. 	
    //	if ([[button currentTitle] isEqual: @"Record"]) {
    if( !recordingNow ) {
        
        // set recording now to true
        recordingNow = YES;
        
        @try {
            
            [[NUSASession sharedSession] startRecording: nil]; 
            
            NSLog( @"=======> recording started... ");
        }
        @catch ( NSException * exception ) {
            NSLog( @"===========>Exception thrown: %@", [exception name]);
            NSLog( @"===========>Exception reason: %@", [exception reason]);
        }
        
	}
	else {        
        // set recording now to false
        recordingNow = NO;
        
		[[NUSASession sharedSession] stopRecording];  
        NSLog( @"=======> recording stopped... ");
	}
}

#pragma mark -
#pragma mark NUSASessionDelegate messages 

- (void) sessionDidStartRecording {
    
    NSLog( @"SESSION DID START RECORDING CALLED!" );
	// This delegate message is sent in case recording was started by the user. Sending the startRecording: message 
	// to the NUSASession instance does not send trigger this message. We react by changing the toggle record button 
	// title. 
//	[button setTitle: @"Stop" forState: UIControlStateNormal];
}

- (void) sessionDidStopRecording {
    
    
    NSLog( @"SESSION DID STOP RECORDING CALLED!" );
	// This delegate message is sent in case recording was stopped by the user or in case of an error. Sending the 
	// stopRecording message to the NUSASession instance does not trigger this message. We react by changing the toggle 
	// record button title. In case an error occured, the user will be informed by the Nuance SpeechAnywhere SDK. 
//	[button setTitle: @"Record" forState: UIControlStateNormal];  
    
//    [recordedTextLabel setText: [textField text]];
}


@end
