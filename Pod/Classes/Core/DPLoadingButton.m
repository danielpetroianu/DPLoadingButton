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
    DPLoadingButtonAction _buttonAction;
    DPLoadingButtonCompletionHandler _completionHandler;
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

- (void)addAction:(DPLoadingButtonAction)action forControlEvents:(UIControlEvents)controlEvents
{
    [self addAction:action withCompletion:nil forControlEvents:UIControlEventTouchUpInside];
}

- (void)addAction:(DPLoadingButtonAction)action withCompletion:(DPLoadingButtonCompletionHandler)completionHandler forControlEvents:(UIControlEvents)controlEvents
{
    _buttonAction = [action copy];
    _completionHandler = [completionHandler copy];
    
    [self addTarget:self action:@selector(buttonWasTapped:) forControlEvents:controlEvents];
}

#pragma mark - Helpers

- (void)createSubviews {
    [self setActivityIndicatorView:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]];
    [self addSubview:[self activityIndicatorView]];
}

- (void)buttonWasTapped:(id) sender
{
    if(_buttonAction){
        [self startAnimating];
        
        __weak typeof(self) wSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            __strong typeof(self) sSelf = wSelf;
            _buttonAction(sSelf);
            
            [sSelf stopAnimating];
            
            if(_completionHandler){
                dispatch_async(dispatch_get_main_queue(), ^{
                    _completionHandler(sSelf);
                });
            }
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


@implementation DPLoadingButton (Deprecated)

- (void)onButtonTap:(DPLoadingButtonAction)block
{
    [self addAction:block withCompletion:nil forControlEvents:UIControlEventTouchUpInside];
}

@end