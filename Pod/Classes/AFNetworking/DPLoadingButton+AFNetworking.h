//
//  DPLoadingButton+AFNetworking.h
//  Pods
//
//  Created by Petroianu Daniel on 7/25/14.
//
//

#import "DPLoadingButton.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

@class AFURLConnectionOperation;

/**
 *  Block type for defining the button's action after the control events happen
 *
 *  @param   button  The button that was pressed
 *
 *  @return  The `AFURLConnectionOperation` that handles the request
 */
typedef AFURLConnectionOperation *(^DPLoadingButtonRequestOperationAction)(DPLoadingButton *button);

/**
 *  Category over AFNetworking that automatically starts and stops animation depending on the loading state of a request operation
 *  This is mostly a copy of AFNetworking/UIActivityIndicatorView+AFNetworking.h from AFNetworking UIKit subpod in order to call `- startAnimating` and `- stopAnimating` on the button.
 */
@interface DPLoadingButton (AFNetworking_RequestOperation)

/**
 *  Register a block that will return and AFURLConnectionOperation used to animate the UIActivityIndicatorView from the button.
 *
 *  @param   block         A block of code that will be executed when the button is pressed
 *  @param   controlEvents A bitmask specifying the control events for which the action block is executed. @see UIControlEvents.
 *
 *  @warning The block is saved in an internal property and it might/will cause a retain cicle. Use the 'weakSelf' - 'strongSelf' pattern when refering to 'self' inside the blocks. More info: http://blackpixel.com/blog/2014/03/capturing-myself.html
*/
- (void)startAnimatingWithRequestOperation:(DPLoadingButtonRequestOperationAction)action forControlEvents:(UIControlEvents)controlEvents;

@end

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000

/**
 *  Block type for defining the button's action after the control events happen
 *
 *  @param   button  The button that was pressed
 *
 *  @return  The `NSURLSessionTask` that handles the request
 */
typedef NSURLSessionTask *(^DPLoadingButtonURLSessionTaskAction)(DPLoadingButton *button);

/**
 *  Category over AFNetworking that automatically starts and stops animation depending on the loading state of a session task
 *  This is mostly a copy of AFNetworking/UIActivityIndicatorView+AFNetworking.h from AFNetworking UIKit subpod in order to call `- startAnimating` and `- stopAnimating` on the button.
 */
@interface DPLoadingButton (AFNetworking_SessionTask)

/**
 *  Register a block that will return and NSURLSessionTask used to animate the UIActivityIndicatorView from the button.
 *
 *  @param   block         A block of code that will be executed when the button is pressed
 *  @param   controlEvents A bitmask specifying the control events for which the action block is executed. @see UIControlEvents.
 *
 *  @warning The block is saved in an internal property and it might/will cause a retain cicle. Use the 'weakSelf' - 'strongSelf' pattern when refering to 'self' inside the blocks. More info: http://blackpixel.com/blog/2014/03/capturing-myself.html
 */
- (void)startAnimatingWithTask:(DPLoadingButtonURLSessionTaskAction)action forControlEvents:(UIControlEvents)controlEvents;

@end
#endif


@interface DPLoadingButton (AFNetworking_Deprecated)

- (void)startRequestOperationOnButtonTap:(DPLoadingButtonRequestOperationAction)block DEPRECATED_MSG_ATTRIBUTE("use - (void)startAnimatingWithRequestOperation:(DPLoadingButtonRequestOperationAction)block forControlEvents:(UIControlEvents)controlEvents");


#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000

- (void)startTaskOnButtonTap:(DPLoadingButtonURLSessionTaskAction)block DEPRECATED_MSG_ATTRIBUTE("use - (void)startAnimatingWithTask:(DPLoadingButtonURLSessionTaskAction)block forControlEvents:(UIControlEvents)controlEvents;");

#endif

@end

#endif
