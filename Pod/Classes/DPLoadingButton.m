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

#pragma mark - private methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupControl];
    }
    return self;
}

- (void)setupControl
{
    [self setActivityIndicatorView:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]];
    [self addSubview:[self activityIndicatorView]];
}

- (void)layoutSubviews
{
    CGRect frame = [self frame];
    
    [[self activityIndicatorView] setCenter:CGPointMake(frame.size.width/2, frame.size.height/2)];
}



#pragma mark - public methods

- (void)startAnimating
{
    [[self activityIndicatorView] startAnimating];
}

- (void)stopAnimating
{
    [[self activityIndicatorView] stopAnimating];
}

@end
