//
//  UIView+NUSAEnabled.h
//  Nuance SpeechAnywhere
//
//  Copyright 2011 Nuance Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/** @brief Voice user interface (VUI) extension to the UIView interface.
 
	@xmlonly<nmFramework>NuanceSpeechAnywhere</nmFramework>@endxmlonly
	@since 1.0
 
 */
@interface UIView (NUSAEnabled)

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Speech enabling a view
//////////////////////////////////////////////////////////////////////////////////////////

/** @brief Enables or disables speech recognition support for UIViews. 
 
	@since 1.0
 
	Set the vuiEnabled property of a UIView to NO to exclude the view from being speech 
	enabled by Nuance SpeechAnywhere. The default is YES for UITextField and UITextView type views. Setting
	the property for any other type of UIView descendants, has no effect and will default 
	to NO.
 
	The vuiEnabled property should be set at the time your UIView did load. Once recording is started,
	setting the vuiEnabled property does not have an effect. 
 
	@param enabled The new enabled state. If set to false, the view will not be speech enabled. The default 
		is YES for UITextField and UITextView views. 
 */
- (void) setVuiEnabled: (BOOL) enabled; 

/** @brief Returns whether the view is speech-enabled or not. 
 
	@since 1.0
 
	@return	Returns whether the view is speech-enabled or not.   
 */
- (BOOL) vuiEnabled; 

@end