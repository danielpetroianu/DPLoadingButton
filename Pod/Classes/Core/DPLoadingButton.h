//
//  DPLoadingButton.h
//  Pods
//
//  Created by Petroianu Daniel on 7/18/14.
//
//

#import <UIKit/UIKit.h>

@class DPLoadingButton;

typedef void (^DPLoadingButtonAction)(DPLoadingButton *button);
typedef void (^DPLoadingButtonCompletionHandler)(DPLoadingButton *button);


/**
 A 'button like' control that displayes a UIActivityIndicatorView when the button is tapped.
 */
@interface DPLoadingButton : UIControl

/**
 The UIActivityIndicatorView that will be used to display the loading animation.
 
 @discussion
 Although this property is read-only, its own properties are read/write. Use these properties to configure the style of the loading view. For example:
    DPLoadingButton *button                                 = [[DPLoadingButton alloc] initWithTitle:@"some title"];
    button.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    button.activityIndicatorView.color                      = [UIColor blackColor];
 */
@property(nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicatorView;

/**
 A view that displays the value the title used when the button was initialized.
 
 @discussion
 Although this property is read-only, its own properties are read/write. Use these properties to configure the text of the button. For example:
    DPLoadingButton *button           = [[DPLoadingButton alloc] initWithTitle:@"some title"];
    button.titleLabel.font            = [UIFont systemFontOfSize: 12];
    button.titleLabel.lineBreakMode   = UILineBreakModeTailTruncation;
 If - (instancetype)initWithTitle:(NSString *)title wasn't used this will be nil.
 */
@property(nonatomic, strong, readonly) UILabel *titleLable;


/**
 Initializes a new item using the specified image.
 
 @param image The image to display in the button.
 
 @return An initialized DPLoadingButton object or nil if the object couldn't be created.
 
 @discussion This method adjusts the frame of the receiver to match the size of the specified image.
 */
- (instancetype)initWithImage:(UIImage *)image;

/**
 Initializes a new item using the specified title.
 
 @param title The text to display in the button.
 
 @return An initialized DPLoadingButton object or nil if the object couldn't be created.
 
 @discussion This method adjusts the frame of the receiver to match the size of the specified title.
 */
- (instancetype)initWithTitle:(NSString *)title;

/**
 Initializes a new item using the specified custom view.
 
 @param view A custom view representing the item.
 
 @return An initialized DPLoadingButton object or nil if the object couldn't be created.
 
 @discussion This method adjusts the frame of the receiver to match the size of the specified view. It also disables user interactions for the custom view by default, so that the tap action on the button could be recognised.
 */
- (instancetype)initWithCustomView:(UIView *)view;

/**
 Register action blocks that will be executed when the specified controlEvents happen.
 
 @param action        A block that will be executed on a background thread on the button 'controlEvents'.
 @param controlEvents A bitmask specifying the control events for which the action block is executed. @see UIControlEvents.
 */
- (void)addAction:(DPLoadingButtonAction)action forControlEvents:(UIControlEvents)controlEvents;

/**
 Register action blocks that will be executed when the specified controlEvents happen.
 
 @param action            A block that will be executed on a background thread on the button 'controlEvents'.
 @param completionHandler A block that will be executed after the action block execution
 @param controlEvents     A bitmask specifying the control events for which the action block is executed. @see UIControlEvents.
 */
- (void)addAction:(DPLoadingButtonAction)action withCompletion:(DPLoadingButtonCompletionHandler)completionHandler forControlEvents:(UIControlEvents)controlEvents;

/**
 Calls the startAnimating methond on the activityIndicatorView.
 @discussion This will make sure that the animation is done on the main thread. It will automatically be called before onButtonTap is called.
 */
- (void)startAnimating;

/**
 Calls the stopAnimating methond on the activityIndicatorView.
 @discussion This will make sure that the animation is done on the main thread. It will automatically be called after onButtonTap is called.
 */
- (void)stopAnimating;

@end


/**
 UIKit helpers
 */
@interface DPLoadingButton (UIKit)

/**
 Helper method that will return an UIBarButtonItem.
 
 @return A UIBarButtonItem with this DPLoadingButton as it's view.
 */
- (UIBarButtonItem *)toBarButtonItem;

@end

@interface DPLoadingButton (Deprecated)
/**
 Register a block that will be run when the button is tapped.
 The block execution will be done on a background thread.
 
 @param block A block that will be executed on a background thread when the button is pressed.
 */
- (void)onButtonTap:(DPLoadingButtonAction)block DEPRECATED_MSG_ATTRIBUTE("use (void)addAction:(DPLoadingButtonAction)action forControlEvents:(UIControlEvents)controlEvents");

@end

