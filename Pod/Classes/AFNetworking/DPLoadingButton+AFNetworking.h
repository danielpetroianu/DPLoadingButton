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
typedef AFURLConnectionOperation *(^DPLoadingButtonRequestOperationAction)(DPLoadingButton *button);

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
typedef NSURLSessionTask *(^DPLoadingButtonURLSessionTaskAction)(DPLoadingButton *button);
#endif

/**
 [COPY OF AFNetworking/UIActivityIndicatorView+AFNetworking.h]
 Category over AFNetworking that automatically starts and stops animation depending on the loading state of a request operation or session task
 */
@interface DPLoadingButton (AFNetworking)

/**
 Register a block that will return and AFURLConnectionOperation used to animate the UIActivityIndicatorView from the button.
 
 @param  block  A block of code that will be executed when the button is pressed
 
 @warning
     The block is saved in an internal property and it might/will cause a retain cicle.
     Use the 'weakSelf' - 'strongSelf' pattern when refering to 'self' inside the blocks.
     More info: http://blackpixel.com/blog/2014/03/capturing-myself.html
 */
- (void)startAnimatingWithRequestOperation:(DPLoadingButtonRequestOperationAction)block forControlEvents:(UIControlEvents)controlEvents;


#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
/**
 Register a block that will return and NSURLSessionTask used to animate the UIActivityIndicatorView from the button.
 
 @param  block  A block of code that will be executed when the button is pressed
 
 @warning
     The block is saved in an internal property and it might/will cause a retain cicle.
     Use the 'weakSelf' - 'strongSelf' pattern when refering to 'self' inside the blocks.
     More info: http://blackpixel.com/blog/2014/03/capturing-myself.html
 */
- (void)startAnimatingWithTask:(DPLoadingButtonURLSessionTaskAction)block forControlEvents:(UIControlEvents)controlEvents;
#endif

@end



@interface DPLoadingButton (AFNetworking_Deprecated)

/**
 Register a block that will return and AFURLConnectionOperation used to animate the UIActivityIndicatorView from the button.
 
 @param  block  A block of code that will be executed when the button is pressed
 
 @warning
 The block is saved in an internal property and it might/will cause a retain cicle.
 Use the 'weakSelf' - 'strongSelf' pattern when refering to 'self' inside the blocks.
 More info: http://blackpixel.com/blog/2014/03/capturing-myself.html
 */
- (void)startRequestOperationOnButtonTap:(DPLoadingButtonRequestOperationAction)block DEPRECATED_MSG_ATTRIBUTE("use - (void)startAnimatingWithRequestOperation:(DPLoadingButtonRequestOperationAction)block forControlEvents:(UIControlEvents)controlEvents");



#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
/**
 Register a block that will return and NSURLSessionTask used to animate the UIActivityIndicatorView from the button.
 
 @param  block  A block of code that will be executed when the button is pressed
 
 @warning
 The block is saved in an internal property and it might/will cause a retain cicle.
 Use the 'weakSelf' - 'strongSelf' pattern when refering to 'self' inside the blocks.
 More info: http://blackpixel.com/blog/2014/03/capturing-myself.html
 */
- (void)startTaskOnButtonTap:(DPLoadingButtonURLSessionTaskAction)block DEPRECATED_MSG_ATTRIBUTE("use - (void)startAnimatingWithTask:(DPLoadingButtonURLSessionTaskAction)block forControlEvents:(UIControlEvents)controlEvents;");

#endif

@end

#endif
