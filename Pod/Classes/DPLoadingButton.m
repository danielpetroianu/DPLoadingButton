//
//  DPLoadingButton.m
//  Pods
//
//  Created by Petroianu Daniel on 7/18/14.
//
//

#import "DPLoadingButton.h"

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
    }
    
    return self;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupControl];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupControl];
    }
    return self;
}

- (void)setupControl
{
    [self createSubviews];
    [self bindEvents];
}


- (void)layoutSubviews
{
    CGRect frame = [self frame];
    
    [[self activityIndicatorView] setCenter:CGPointMake(frame.size.width/2, frame.size.height/2)];
}



#pragma mark - Properties

- (void)startAnimating
{
    [UIView animateWithDuration:0.5 animations:^{
        [[self viewWithTag:1010] setAlpha:0.2];
    } completion:^(BOOL finished) {
        [[self activityIndicatorView] startAnimating];
    }];
}

- (void)stopAnimating
{
    [[self activityIndicatorView] stopAnimating];
    [UIView animateWithDuration:0.5 animations:^{
        [[self viewWithTag:1010] setAlpha:1];
    }];
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
