//
//  DPLoadingButton.h
//  Pods
//
//  Created by Petroianu Daniel on 7/18/14.
//
//

#import <UIKit/UIKit.h>

@interface DPLoadingButton : UIControl

@property(nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicatorView;

- (void)startAnimating;

- (void)stopAnimating;

@end
