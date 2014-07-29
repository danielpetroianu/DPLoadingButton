//
//  DPLoadingButton.m
//  Pods
//
//  Created by Petroianu Daniel on 7/18/14.
//
//

#import "DPLoadingButton.h"

#define dp_dispatch_main_async_safe(block)\
        if ([NSThread isMainThread]) {\
            block();\
        } else {\
            dispatch_async(dispatch_get_main_queue(), block);\
        }

@interface DPLoadingButton () {
    DPLoadingButtonAction _onButtonTap;
}

@property(nonatomic, strong, readwrite) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic, strong, readwrite) UILabel *titleLable;

@property(nonatomic, weak) UIView *buttonView;

@end

@implementation DPLoadingButton


#pragma mark - Life Cycle

- (instancetype)initWithImage:(UIImage *)image
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    
    return [self initWithCustomView:imgView];
}

- (instancetype)initWithTitle:(NSString *)title
{
    [self setTitleLable:[[UILabel alloc] initWithFrame:CGRectZero]];
    [[self titleLable] setBackgroundColor:[UIColor clearColor]];
    [[self titleLable] setText:title];
    [[self titleLable] sizeToFit];
    
    return [self initWithCustomView:[self titleLable]];
}

- (instancetype)initWithCustomView:(UIView *)view
{
    if(self = [self initWithFrame:[view frame]])
    {
        [view setUserInteractionEnabled:NO];
        [self addSubview:view];
        [self setButtonView:view];

        [self createSubviews];
    }
    
    return self;
}

- (void)layoutSubviews
{
    CGRect frame = [self frame];
    
    [[self activityIndicatorView] setCenter:CGPointMake(frame.size.width/2, frame.size.height/2)];
}


#pragma mark - Properties

- (void)startAnimating
{
    dp_dispatch_main_async_safe(^{
        [[self activityIndicatorView] setAlpha:0.2];
        [[self activityIndicatorView] startAnimating];
        [self setEnabled:NO];
        
        [UIView animateWithDuration:0.3 animations:^{
            [[self buttonView] setAlpha:0.2];
            [[self activityIndicatorView] setAlpha:1.0];
        }];
    });
}

- (void)stopAnimating
{
    dp_dispatch_main_async_safe(^{
        [[self activityIndicatorView] stopAnimating];
        
        [UIView animateWithDuration:0.3 animations:^{
            [[self buttonView] setAlpha:1];
        } completion:^(BOOL finished) {
            [self setEnabled:YES];
        }];
    });
}

- (void)onButtonTap:(DPLoadingButtonAction)block
{
    _onButtonTap = [block copy];
    [self addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Helpers

- (void)createSubviews {
    [self setActivityIndicatorView:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]];
    [self addSubview:[self activityIndicatorView]];
}

- (void)buttonWasTapped:(id) sender
{
    if(_onButtonTap){
        [self startAnimating];
        
        __weak typeof(self) wSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            __strong typeof(self) sSelf = wSelf;
            _onButtonTap(sSelf);
            
            [sSelf stopAnimating];
        });
    }
}

@end


@implementation DPLoadingButton (UIKit)

- (UIBarButtonItem *)toBarButtonItem
{
    return [[UIBarButtonItem alloc] initWithCustomView:self];
}

@end
