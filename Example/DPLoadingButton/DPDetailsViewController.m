//
//  DPDetailsViewController.m
//  DPLoadingButton
//
//  Created by Petroianu Daniel on 7/29/14.
//  Copyright (c) 2014 Petroianu Daniel. All rights reserved.
//

#import "DPDetailsViewController.h"


@interface DPDetailsViewController ()
@property(nonatomic, weak) IBOutlet DPLoadingButton *brewCoffeeButton;
@end

@implementation DPDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DPLoadingButton *customViewButton = [self createCustomViewButton];
    [[self view] addSubview:customViewButton];
    [self setBrewCoffeeButton:customViewButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self alignView:[self brewCoffeeButton] inCenterOf:[self view]];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [self alignView:[self brewCoffeeButton] inCenterOf:[self view]];
}


- (DPLoadingButton *)createCustomViewButton {
    // Example of DPLoadingButton created with a custom view
    
    UINib *nib = [UINib nibWithNibName:@"DPCustomView" bundle:nil];
    UIView *customView = [[nib instantiateWithOwner:nil options:nil] firstObject];
    
    DPLoadingButton *button = [[DPLoadingButton alloc] initWithCustomView:customView];
    [[button activityIndicatorView] setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [[button activityIndicatorView] setColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    
    [button addAction:^(DPLoadingButton *button){
        NSLog(@"custom view button was tapped %@", button);
        [NSThread sleepForTimeInterval:2];
    } withCompletion:^(DPLoadingButton *button) {
        NSLog(@"custom view button finished running action %@", button);
        UIAlertView *alertView = [[UIAlertView alloc] init];
        [alertView setMessage:@"Go get your coffee."];
        [alertView addButtonWithTitle:@"I'm going"];
        [alertView show];
    }];
    
    return button;
}

- (void)alignView:(UIView *)view inCenterOf:(UIView *)container
{
    CGRect viewFrame = [view frame];
    viewFrame.origin.x = (CGRectGetWidth([container bounds]) - CGRectGetWidth([view bounds])) / 2;
    viewFrame.origin.y = (CGRectGetHeight([container bounds]) - CGRectGetHeight([view bounds])) / 2;
    
    [view setFrame:viewFrame];
}

@end
