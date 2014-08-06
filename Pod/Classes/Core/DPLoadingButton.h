//
//  DPLoadingButton.h
//  Pods
//
//  Created by Petroianu Daniel on 7/18/14.
//
//

#import <UIKit/UIKit.h>

@class DPLoadingButton;

/**
 *  Block type for defining the button's action after the control events happen
 *
 *  @param   button  The button that was pressed
 */
typedef void (^DPLoadingButtonAction)(DPLoadingButton *button);

/**
 *  Type for defining the block that handles the action to take after the buttons stops animating and fires the control events action
 *
 *  @param   button  The button that was pressed
 */
typedef void (^DPLoadingButtonCompletionHandler)(DPLoadingButton *button);


/**
 A 'button like' control that displayes a UIActivityIndicatorView when the button fires a control event.
 
 :returns: An `UIControl`
 */
@interface DPLoadingButton : UIControl

/**
 *  The UIActivityIndicatorView that will be used to display the loading animation.
 *
 *  @note    Although this property is read-only, its own properties are read/write. Use these properties to configure the style of the loading view. For example:
 *
 *    DPLoadingButton *button                                 = [[DPLoadingButton alloc] initWithTitle:@"some title"];
 *    button.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
 *    button.activityIndicatorView.color                      = [UIColor blackColor];
 */
@property(nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicatorView;

/**
 *  A view that displays the value the title used when the button was initialized.
 *
 *  @note    Although this property is read-only, its own properties are read/write. Use these properties to configure the text of the button.
 *           If - `initWithTitle:` wasn't used this will be nil. For example:
 *
 *    DPLoadingButton *button           = [[DPLoadingButton alloc] initWithTitle:@"some title"];
 *    button.titleLabel.font            = [UIFont systemFontOfSize: 12];
 *    button.titleLabel.lineBreakMode   = UILineBreakModeTailTruncation;
 */
@property(nonatomic, strong, readonly) UILabel *titleLable;


/**
 *  Initializes a new item using the specified image.
 *
 *  @param   image  The image to display in the button.
 *
 *  @return  Returns an initialized DPLoadingButton object or nil if the object couldn't be created.
 *
 *  @note    This method adjusts the frame of the button to match the size of the specified image.
 */
- (instancetype)initWithImage:(UIImage *)image;

/**
 *  Initializes a new item using the specified title.
 *
 *  @param   title  The text to display in the button.
 *
 *  @return  Returns an initialized DPLoadingButton object or nil if the object couldn't be created.
 *
 *  @note    This method adjusts the frame of the button to match the size of the specified title.
 */
- (instancetype)initWithTitle:(NSString *)title;

/**
 *  Initializes a new item using the specified custom view.
 *
 *  @param   view   A custom view representing the item.
 *
 *  @return  Returns an initialized DPLoadingButton object or nil if the object couldn't be created.
 *
 *  @note    This method adjusts the frame of the button to match the size of the specified view.
 *           It also disables user interactions for the custom view by default, so that the button control events could be recognised.
 */
- (instancetype)initWithCustomView:(UIView *)view;

/**
 *  Register action blocks that will be executed when the button is tapped (`UIControlEventTouchUpInside`).
 *
 *  @param   action   A block that will be executed on a background thread on the button `controlEvents`.
 *
 *  @note    The `DPLoadingButtonAction` execution will be done on a background thread.
 *
 *  @warning The `DPLoadingButtonAction` is saved in an internal property and it might/will cause a retain cicle. Use the 'weakSelf' - 'strongSelf' pattern when refering to `self` inside the blocks. More info: http://blackpixel.com/blog/2014/03/capturing-myself.html
 */
- (void)addAction:(DPLoadingButtonAction)action;

/**
 *  Register action blocks that will be executed when the specified controlEvents happen.
 *
 *  @param   action         A block that will be executed on a background thread on the button `controlEvents`.
 *  @param   controlEvents  A bitmask specifying the control events for which the action block is executed. @see `UIControlEvents`.
 *
 *  @note    The `DPLoadingButtonAction` execution will be done on a background thread.
 *
 *  @warning The `DPLoadingButtonAction` is saved in an internal property and it might/will cause a retain cicle. Use the 'weakSelf' - 'strongSelf' pattern when refering to `self` inside the blocks. More info: http://blackpixel.com/blog/2014/03/capturing-myself.html
 */
- (void)addAction:(DPLoadingButtonAction)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  Register action blocks that will be executed when the button is tapped (`UIControlEventTouchUpInside`).
 *
 *  @param   action             A block that will be executed on a background thread on the button `controlEvents`.
 *  @param   completionHandler  A block that will be executed after the action block execution
 *
 *  @note    The `DPLoadingButtonAction` execution will be done on a background thread and the `DPLoadingButtonCompletionHandler` will be execution will be done on the main thread.
 *
 *  @warning The `DPLoadingButtonAction` and `DPLoadingButtonCompletionHandler` are saved in an internal property and it might/will cause a retain cicle. Use the 'weakSelf' - 'strongSelf' pattern when refering to `self` inside the blocks. More info: http://blackpixel.com/blog/2014/03/capturing-myself.html
 */
- (void)addAction:(DPLoadingButtonAction)action withCompletion:(DPLoadingButtonCompletionHandler)completionHandler;

/**
 *  Register action blocks that will be executed when the specified controlEvents happen.
 *
 *  @param   action             A block that will be executed on a background thread on the button `controlEvents`.
 *  @param   completionHandler  A block that will be executed after the action block execution
 *  @param   controlEvents      A bitmask specifying the control events for which the action block is executed. @see UIControlEvents.
 *
 *  @note    The `DPLoadingButtonAction` block execution will be done on a background thread and the `DPLoadingButtonCompletionHandler` block will be execution will be done on the main thread.
 *
 *  @warning The `DPLoadingButtonAction` and `DPLoadingButtonCompletionHandler` are saved in an internal property and it might/will cause a retain cicle. Use the 'weakSelf' - 'strongSelf' pattern when refering to `self` inside the blocks. More info: http://blackpixel.com/blog/2014/03/capturing-myself.html
 */
- (void)addAction:(DPLoadingButtonAction)action withCompletion:(DPLoadingButtonCompletionHandler)completionHandler forControlEvents:(UIControlEvents)controlEvents;

/**
 * Calls the startAnimating methond on the activityIndicatorView.
 *
 *  @note    This will make sure that the animation is done on the main thread.
 *           It will automatically be called before the `DPLoadingButtonAction` block is executed, but in case you need to show it as animating for some other reason you can call it.
 */
- (void)startAnimating;

/**
 *  Calls the stopAnimating methond on the activityIndicatorView.
 *
 *  @note    This will make sure that the animation is done on the main thread.
 *           It will automatically be called before the `DPLoadingButtonAction` block is executed, but in case you need to stop it from animating for some other reason you can call it.
 */
- (void)stopAnimating;

@end


/**
 *  UIKit helpers
 */
@interface DPLoadingButton (UIKit)

/**
 *  Helper method that will return an UIBarButtonItem.
 *
 *  @return  A `UIBarButtonItem` with this DPLoadingButton as it's view.
 */
- (UIBarButtonItem *)toBarButtonItem;

@end

@interface DPLoadingButton (Deprecated)

- (void)onButtonTap:(DPLoadingButtonAction)block DEPRECATED_MSG_ATTRIBUTE("use (void)addAction:(DPLoadingButtonAction)action forControlEvents:(UIControlEvents)controlEvents");

@end

