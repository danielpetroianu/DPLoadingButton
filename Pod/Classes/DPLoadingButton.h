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

@property(nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic, strong, readonly) UILabel *titleLable;

@property(nonatomic, copy) DPLoadingButtonAction onButtonTap;

- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithCustomView:(UIView *)view;

- (void)startAnimating;
- (void)stopAnimating;

@end
