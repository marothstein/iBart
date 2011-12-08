//
//  InputViewController.h
//  iBart
//
//  Created by Matt on 5/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iBartAppDelegate.h"

#import "NUSASession.h"
#import "NUSAVuiController.h"


@protocol InputViewControllerDelegate;

@interface InputViewController : UIViewController <NUSASessionDelegate> {
    
    UITextView *textView;
    UILabel *fieldNameLabel;
    
	NUSAVuiController *vuiController; 
    
    BOOL recordingNow;
    
    id<InputViewControllerDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UILabel *fieldNameLabel;

@property (nonatomic, retain) IBOutlet NUSAVuiController* vuiController;

@property (nonatomic, retain) IBOutlet id<InputViewControllerDelegate> delegate;

@property (nonatomic, assign) BOOL recordingNow; 


- (IBAction) doneAction: (id) sender; 
- (IBAction) toggleRecordingAction: (id) sender; 

// non IBAction methods
- (void) setText: (NSString *) text;
- (void) setFieldNameLabelText:(NSString *) fieldName;

@end

@protocol InputViewControllerDelegate <NSObject>

- (void) finishInputAndPassBackText: (NSString *) text;

@end
