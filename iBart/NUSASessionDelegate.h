//
//  NUSASessionDelegate.h
//  Nuance SpeechAnywhere
//
//  Copyright 2011 Nuance Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** @brief NUSASession delegate messages.
 
	@xmlonly<nmFramework>Nuance SpeechAnywhere</nmFramework>@endxmlonly
	@since 1.0
 
	Delegate messages sent by the NUSASession class to its delegate receiver. All messages 
	provided by the protocol are optional and can be implemented by the receiver. 
*/
@protocol NUSASessionDelegate <NSObject>
@optional

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Recording sessions
//////////////////////////////////////////////////////////////////////////////////////////

/** @brief Sent after audio data recording has started￼.
	@since 1.0
	
	Sent to the delegate whenever a recording session is started.
 */
- (void) sessionDidStartRecording;

/** @brief Sent after audio data recording has stopped.
	@since 1.0
 
	Sent to the delegate whenever a recording session is finished. Reasons for stopping a recording 
	session can be your integration calling stopRecording:(), the user using a gesture to stop 
	recording or an error situation. 
 */
- (void) sessionDidStopRecording;

@end
