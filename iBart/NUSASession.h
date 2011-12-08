//
//  NUSASession.h
//  Nuance SpeechAnywhere
//
//  Copyright 2011 Nuance Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUSATypes.h"
#import "NUSASessionDelegate.h"

@class NUSAVuiController; 

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** @brief Representation of a mobile speech session.
 
	@xmlonly<nmFramework>NuanceSpeechAnywhere</nmFramework>@endxmlonly
	@since 1.0
 
	This interface manages the authentication and licensing with the web service provider 
	via the information passed in the openForApplication:partnerGuid:licenseGuid:userId:() 
	message and audio sessions via startRecording:() and stopRecording(). Once a session 
	is opened, it will stay open (usable) until explicitly closed via close(); this frees 
	the web service resources and releases the license, if applicable. The session instance 
	communicates asynchronous messages to its delegate, if set. The delegate methods are 
	not mandatory. 
 
	There is exactly one session instance available to an application; it is retrievable 
	via the sharedSession() class method. Usually the application will open the session as 
	soon as user credentials are available and keep it open for the lifetime of the 
	application. 
*/
@interface NUSASession : NSObject {
	@protected	
	id<NUSASessionDelegate>	delegate; 
}

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Properties
//////////////////////////////////////////////////////////////////////////////////////////

/** @brief NUSASession delegate.
	@since 1.0

	This delegate receives messages from the session instance. Delegates must 
	conform to the NUSASessionDelegate protocol. The delegate will not be 
	retained. 
 */
@property (nonatomic, assign) id<NUSASessionDelegate> delegate; 


//////////////////////////////////////////////////////////////////////////////////////////
/// @name Getting the session instance
//////////////////////////////////////////////////////////////////////////////////////////

/** @brief Returns the shared client session instance.
	@since 1.0

	Returns the shared Nuance SpeechAnywhere client session instance. The shared session instance 
	is guaranteed to be valid throughout the life time of your application. 
 
	@return The shared Nuance SpeechAnywhere client session instance.
*/
+ (NUSASession*) sharedSession;

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Authenticating with the service
//////////////////////////////////////////////////////////////////////////////////////////


/** @brief Authenticates a user with the Nuance SpeechAnywhere Service.
	@since 1.0

	This message creates a connection to the Nuance SpeechAnywhere service and authenticates 
	the application, user and account information as passed. Sessions are usually opened as 
	soon as user credentials are available in your application. Licensing errors will 
	be displayed to the end user of your application.
 
	Note that the Nuance SpeechAnywhere Service will automatically free user licenses if there are 
	longer periods of inactivity. In these cases you do not need to explicitly reopen or close the 
	session; the license will be reaquired automatically with the next user activity, e.g. starting 
	a recording session.
  
	If the licenseGuid or partnerGuid parameter were not specified (e.g. a @c nil object was passed), 
	Nuance SpeechAnywhere will not try to verify the license with the web service and will not offer 
	speech recognition related functionality to the end user or your application - it has the same effect 
	as not calling the method at all. E.g. calling startRecording:() will not have any effect. 
 
	@warning Raises an NSInvalidArgumentException in cases where a mandatory parameter was not 
		properly passed, e.g. an empty string or a @c nil object. 
 
	@param userId			Mandatory user ID of the author. The user ID must be a non-empty string. 
	@param licenseGuid		Optional license GUID. Invalid license GUIDs will be rejected during runtime and 
							cause an alert message to appear to the end user.  
    @param partnerGuid		Optional partner GUID. Invalid partner guids will be rejected during runtime and 
							cause an alert message to appear to the end user. 
	@param applicationName	Mandatory application name. The application name identifies your application on the 
							web service and can be chosen by your integration. The application name is not 
							part of the licensing information; it can be any string up to 50 characters in length. 
 */
- (void) openForApplication: (NSString*) applicationName partnerGuid: (NSString*) partnerGuid licenseGuid: (NSString*) licenseGuid userId: (NSString*) userId;  

/** @brief Frees web service resources and licenses on the Nuance SpeechAnywhere service.
	@since 1.0

	This message disconnects and frees any speech recognition resources and user licenses on the 
	Nuance SpeechAnywhere service. Usually the session should be closed when the application is 
	shut down, or becomes inactive. 
 
	Note that the Nuance SpeechAnywhere Service will automatically free user licenses transparently 
	to your application in case of longer periods of inactivity. In these cases you do not need to 
	explicitly reopen or close the session; the license will be reaquired automatically by the 
	next user activity, e.g. starting a recording session. 
 */
- (void) close;

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Using speech recognition
//////////////////////////////////////////////////////////////////////////////////////////

/** @brief Starts recording audio data and audio processing on the Nuance SpeechAnywhere Service. 
	@since 1.0

	This message starts recording audio data via the active audio route and starts 
	recognizing recorded and streamed audio data on the Nuance SpeechAnywhere Service. 
	Once started, recording will continue until stopRecording() is called explicitly. Note that 
	recording will also be stopped implicitly after a period of inactivity. The session will send the 
	sessionDidStartRecording() message to its delegate. 
 
	While audio data recording is active, audio data will be sent to the web service to be 
	recognized. Recognized text is then added to the currently active GUI control.
 
	If audio data is already recorded, this method does not do anything. If the session has not 
	been previously opened, the method does not do anything. 
 
	@warning Raises an NUSAInvalidOperationException if called without creating a NUSAVuiController before. 
 
	@param	error	If recording could not be started, error information is passed via this 
					parameter, otherwise @c nil.
	@return			Returns @c NO if recording could not be started. More information about the 
					failure is passed in the error parameter. 
 */
- (BOOL) startRecording: (NSError**) error;

/** @brief Stops recording audio data
	@since 1.0

	Stops recording audio data and requests any pending recognition results from the Nuance
	SpeechAnywhere Service. If recording is not running, this method does not do anything. If the 
	session has not been previously opened, the method does not do anything. The session will send the 
	sessionDidStopRecording message to its delegate. 
 
	@warning Raises a NUSAInvalidOperationException if called without previously creating a NUSAVuiController. 
 */
- (void) stopRecording;

@end
