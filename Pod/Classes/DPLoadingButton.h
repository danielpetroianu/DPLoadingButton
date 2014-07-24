//
//  DPLoadingButton.h
//  Pods
//
//  Created by Petroianu Daniel on 7/18/14.
//
//

#import <UIKit/UIKit.h>

@class DPLoadingButton;

typedef void (^DPLoadingButtonAction)(DPLoadingButton *button) ;


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
 Register a block of code that will be run when the button is tapped.
 */
@property(nonatomic, copy) DPLoadingButtonAction onButtonTap;

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
 Calls the startAnimating methond on the activityIndicatorView.
 @discussion This will make sure that the animation is done on the main thread.
 */
- (void)startAnimating;

/**
 Calls the stopAnimating methond on the activityIndicatorView.
 @discussion This will make sure that the animation is done on the main thread.
 */
- (void)stopAnimating;

@end
