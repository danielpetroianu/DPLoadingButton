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

@interface DPLoadingButton ()

@property(nonatomic, strong, readwrite) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation DPLoadingButton

- (instancetype)initWithImage:(UIImage *)image
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    
    return [self initWithCustomView:imgView];
}

- (instancetype)initWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:title];
    [label sizeToFit];
    
    return [self initWithCustomView:label];
}

- (instancetype)initWithCustomView:(UIView *)view
{
    if([self initWithFrame:[view frame]])
    {
        [view setTag:1010];
        [self addSubview:view];

        [self createSubviews];
        [self bindEvents];
    }
    
    return self;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame
{
    return (self = [super initWithFrame:frame]);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return (self = [super initWithCoder:aDecoder]);
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
        [self setEnabled:NO];
        
        [UIView animateWithDuration:0.5 animations:^{
            [[self viewWithTag:1010] setAlpha:0.2];
        } completion:^(BOOL finished) {
            [[self activityIndicatorView] startAnimating];
        }];
    });
}

- (void)stopAnimating
{
    dp_dispatch_main_async_safe(^{
        [[self activityIndicatorView] stopAnimating];
        
        [UIView animateWithDuration:0.5 animations:^{
            [[self viewWithTag:1010] setAlpha:1];
        } completion:^(BOOL finished) {
            [self setEnabled:YES];
        }];
    });
}

#pragma mark - helpers

- (void)createSubviews {
    [self setActivityIndicatorView:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]];
    [self addSubview:[self activityIndicatorView]];
}

- (void)bindEvents {
    [self addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonWasTapped:(id) sender
{
    if(_onButtonTap){
        [self startAnimating];
        
        _onButtonTap(self);
    }
}

@end
