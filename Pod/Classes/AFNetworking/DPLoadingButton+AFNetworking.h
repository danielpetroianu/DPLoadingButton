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
 
 @param  [DPLoadingButtonRequestOperationAction] block A block of code that will be executed when the button is pressed
 */
- (void)startRequestOperationOnButtonTap:(DPLoadingButtonRequestOperationAction)block;




#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
/**
 Register a block that will return and NSURLSessionTask used to animate the UIActivityIndicatorView from the button.
 
 @param  [DPLoadingButtonURLSessionTaskAction] block A block of code that will be executed when the button is pressed
 */
- (void)startTaskOnButtonTap:(DPLoadingButtonURLSessionTaskAction)block; NS_AVAILABLE_IOS(7.0);
#endif

@end

#endif
