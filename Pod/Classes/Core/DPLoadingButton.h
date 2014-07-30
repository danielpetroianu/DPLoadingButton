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
 A 'button like' control that displayes a UIActivityIndicatorView when the button fires a control event.
 */
@interface DPLoadingButton : UIControl

/**
 The UIActivityIndicatorView that will be used to display the loading animation.
 
 @note   Although this property is read-only, its own properties are read/write. Use these properties to configure the style of the loading view.
 
 @example
 
    DPLoadingButton *button                                 = [[DPLoadingButton alloc] initWithTitle:@"some title"];
    button.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    button.activityIndicatorView.color                      = [UIColor blackColor];
 */
@property(nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicatorView;

/**
 A view that displays the value the title used when the button was initialized.
 
 @note   Although this property is read-only, its own properties are read/write. Use these properties to configure the text of the button.
         If - (instancetype)initWithTitle:(NSString *)title wasn't used this will be nil.
 
 @example
 
    DPLoadingButton *button           = [[DPLoadingButton alloc] initWithTitle:@"some title"];
    button.titleLabel.font            = [UIFont systemFontOfSize: 12];
    button.titleLabel.lineBreakMode   = UILineBreakModeTailTruncation;
 */
@property(nonatomic, strong, readonly) UILabel *titleLable;


/**
 Initializes a new item using the specified image.
 
 @return [DPLoadingButton] Returns an initialized DPLoadingButton object or nil if the object couldn't be created.
 
 @param  [UIImage] image The image to display in the button.
 
 @note   This method adjusts the frame of the button to match the size of the specified image.
 */
- (instancetype)initWithImage:(UIImage *)image;

/**
 Initializes a new item using the specified title.

 @return [DPLoadingButton] Returns an initialized DPLoadingButton object or nil if the object couldn't be created.
 
 @param  [NSString] title The text to display in the button.
 
 @note   This method adjusts the frame of the button to match the size of the specified title.
 */
- (instancetype)initWithTitle:(NSString *)title;

/**
 Initializes a new item using the specified custom view.
 
 @return [DPLoadingButton] Returns an initialized DPLoadingButton object or nil if the object couldn't be created.
 
 @param  [UIView] view A custom view representing the item.
 
 @note   This method adjusts the frame of the button to match the size of the specified view. 
         It also disables user interactions for the custom view by default, so that the button control events could be recognised.
 */
- (instancetype)initWithCustomView:(UIView *)view;

/**
 Register action blocks that will be executed when the specified controlEvents happen.
 
 @param  [DPLoadingButtonAction] action        A block that will be executed on a background thread on the button 'controlEvents'.
 @param  [UIControlEvents] controlEvents A bitmask specifying the control events for which the action block is executed. @see UIControlEvents.
 
 @note   The 'action' block execution will be done on a background thread.
 */
- (void)addAction:(DPLoadingButtonAction)action forControlEvents:(UIControlEvents)controlEvents;

/**
 Register action blocks that will be executed when the specified controlEvents happen.
 
 @param  [DPLoadingButtonAction] action        A block that will be executed on a background thread on the button 'controlEvents'.
 @param  [DPLoadingButtonCompletionHandler] completionHandler A block that will be executed after the action block execution
 @param  [UIControlEvents] controlEvents A bitmask specifying the control events for which the action block is executed. @see UIControlEvents.
 
 @note   The 'action' block execution will be done on a background thread and the 'completionHandler' block will be execution will be done on the main thread.
 */
- (void)addAction:(DPLoadingButtonAction)action withCompletion:(DPLoadingButtonCompletionHandler)completionHandler forControlEvents:(UIControlEvents)controlEvents;

/**
 Calls the startAnimating methond on the activityIndicatorView.
 
 @note   This will make sure that the animation is done on the main thread.
         It will automatically be called before the 'action' block is executed, but in case you need to show it as animating for some other reason you can call it.
 */
- (void)startAnimating;

/**
 Calls the stopAnimating methond on the activityIndicatorView.
 
 @note   This will make sure that the animation is done on the main thread.
         It will automatically be called before the 'action' block is executed, but in case you need to show it as animating for some other reason you can call it.
 */
- (void)stopAnimating;

@end


/**
 UIKit helpers
 */
@interface DPLoadingButton (UIKit)

/**
 Helper method that will return an UIBarButtonItem.
 
 @return [UIBarButtonItem] A UIBarButtonItem with this DPLoadingButton as it's view.
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

