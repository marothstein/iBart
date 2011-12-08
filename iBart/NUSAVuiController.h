//
//  NUSAVuiController.h
//  Nuance SpeechAnywhere
//
//  Copyright 2011 Nuance Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "NUSAVuiControllerDelegate.h" 

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Vui topics 
/// @relates NUSAVuiController
///
/// @brief Constants for the topic property of NUSAVuiController instances. 
///
/// @{
/// 
//////////////////////////////////////////////////////////////////////////////////////////

/** @brief VUI topic for a General Medicine-specific vocabulary 
 *
 *	This is the default topic used for VUI forms if no topic is specified by your integration.
 */
extern const NSString* kNUSAVuiTopicGeneralMedicine; 
/** @brief VUI topic for an Internal Medicine-specific vocabulary */
extern const NSString* kNUSAVuiTopicInternalMedicine;
/** @brief VUI topic for a Surgery-specific vocabulary */
extern const NSString* kNUSAVuiTopicSurgery;
/** @brief VUI topic for a Mentgal Health-specific vocabulary */
extern const NSString* kNUSAVuiTopicMentalHealth; 
/** @brief VUI topic for a Neurology-specific vocabulary */
extern const NSString* kNUSAVuiTopicNeurology; 
/** @brief VUI topic for a Cardiology-specific vocabulary */
extern const NSString* kNUSAVuiTopicCardiology;

/// @}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** @brief Controller managing the voice user interface (VUI) attached to a graphical user interface (GUI)
 
	@xmlonly<nmFramework>NuanceSpeechAnywhere</nmFramework>@endxmlonly
	@since 1.0
 
	This controller manages the VUI aspects of a GUI view and speech-enables controls that 
	are supported by the web service for speech recognition. The VUI controller will initialize 
	with the contents of the GUI view as soon as it is created. The application is responsible 
	for keeping the VUI in sync with changes to the GUI view hierarchy later on (see synchronizeWithView()). 
 
	The NUSAVuiController class is prepared for creation via NIB deserialisation. Alternatively, 
	it can be created programmatically via initWithView:(). 

	Usually each GUI view, that is to be speech enabled, should have a corresponding VUI 
	via attaching its own NUSAVuiController instance to it. The application is responsible 
	for attaching the VUI controller. The lifetime of a VUI controller instance is 
	best bound to the lifetime of the GUI view controller. 
	
*/
@interface NUSAVuiController : NSObject {
	@protected
	UIView*		view;
	NSString*	language; 
	NSString*	topic; 
}

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Properties
//////////////////////////////////////////////////////////////////////////////////////////

/** @brief GUI view this controller is bound to
	@since 1.0
 
	Every VUI controller is connected to a single GUI view (which in turn is 
	bound to a GUI view controller in your application). The VUI controller will inspect 
	the GUI view and create a corresponding VUI form. 
*/
@property (nonatomic, retain) IBOutlet UIView* view;

/** @brief The language to be used by the VUI form.
	@since 1.0
 
	Applications can set the language that should be used by the VUI form. The language can 
	only be set prior to the first recording session. The default is the application language.
 
	The language must be passed in the IETF format (see http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). 
	Currently the SDK expects the IETF language and region subtags to be passed. The language 
	subtag must conform to ISO 639-1 (http://www.loc.gov/standards/iso639-2/php/English_list.php) 
	and is mandatory if set. The region subtag must conform to ISO 3166-1 alpha-2 
	(http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) and is optional. 
 
	Examples: 
	en-US	English (USA)
	en-GB	English (UK)
	de-DE	German (Germany)
	de-AT	German (Austria)
 */
@property (nonatomic, copy) NSString* language;

/** @brief The topic (medical specialty) of the speech recognition vocabulary used by the VUI form
	@since 1.0
 
	Applications can set the topic (speciality) of the speech recognition vocabulary for the 
	VUI form. Setting the topic is optional. 
 */
@property (nonatomic, copy) NSString* topic; 

/** @brief NUSAVuiController delegate.
	@since 1.0
 
	This delegate receives messages from the VUI controller instance. Delegates must 
	conform to the NUSAVuiControllerDelegate protocol. The delegate will not be 
	retained and will send its messages to the thread that set the delegate property. 
*/
@property (nonatomic, assign) id<NUSAVuiControllerDelegate> delegate; 

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Initializing the instance
//////////////////////////////////////////////////////////////////////////////////////////

/** @brief Initializes the VUI controller￼.
	@since 1.0
 
	This message initializes the VUI controller and binds it to the GUI view passed. You can 
	use this initializer if you create the VUI controller manually. You do not need to initialize
	the VUI controller manually via this method if the VUI controller is created as part of your 
	NIB deserialisation. 

	@param aView GUI view that will be speech enabled by this VUI controller object
*/
- (id) initWithView: (UIView*) aView;

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Updating the voice user interface (VUI)
//////////////////////////////////////////////////////////////////////////////////////////
	
/** @brief Synchronizes the VUI form with the GUI view.
	@since 1.0
 
	This method synchronizes the VUI form, controlled by this VUI controller, with the GUI
	of the view object referenced. You must call this method to trigger synchronization
	when the GUI layout of the GUI view contents are changed by your application (e.g. 
	you add or remove controls). 

	Synchronizing should be done once you have updated all of your GUI view contents, so the 
	VUI form can be updated in one step. Additionally, do not synchronize GUI views that are 
	currently not visible to the user, unless you want to pre-cache a GUI view that will be 
	shown in the immediate future. 
*/
- (void) synchronizeWithView; 

@end
