//
//  DPViewController.m
//  DPLoadingButton
//
//  Created by Petroianu Daniel on 07/18/2014.
//  Copyright (c) 2014 Petroianu Daniel. All rights reserved.
//

#import "DPViewController.h"
#import <DPLoadingButton/DPLoadingButton.h>

@interface DPViewController ()
@property(nonatomic, weak) IBOutlet DPLoadingButton *brewCoffeeButton;
@end

@implementation DPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationItem] setLeftBarButtonItem:[self createLeftBarButtonItem]];
	[[self navigationItem] setRightBarButtonItem:[self createRightBarButtonItem]];
    
    DPLoadingButton *customViewButton = [self createCustomViewButton];
    [[self view] addSubview:customViewButton];
    [self setBrewCoffeeButton:customViewButton];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [[self brewCoffeeButton] setCenter:[[self view] center]];
}




- (UIBarButtonItem *)createLeftBarButtonItem {
    NSString *title = @"work";
    DPLoadingButton *leftButton = [[DPLoadingButton alloc] initWithTitle:title];
    [[leftButton titleLable] setTextColor:[UIColor redColor]];
    [[leftButton activityIndicatorView] setColor:[UIColor redColor]];
    [leftButton onButtonTap:^(DPLoadingButton *button){
        NSLog(@"left button was tapped");
        [NSThread sleepForTimeInterval:6];
    }];
    
    return [leftButton toBarButtonItem];
}

- (UIBarButtonItem *)createRightBarButtonItem {
    UIImage *image = [UIImage imageNamed:@"coffee"];
    DPLoadingButton *rightButton = [[DPLoadingButton alloc] initWithImage:image];
    [[rightButton activityIndicatorView] setColor:[UIColor blackColor]];
    
    [rightButton onButtonTap:^(DPLoadingButton *button){
        NSLog(@"right button was tapped");
        [NSThread sleepForTimeInterval:2];
    }];
    
    return [rightButton toBarButtonItem];
}

- (DPLoadingButton *)createCustomViewButton {
    UINib *nib = [UINib nibWithNibName:@"DPCustomView" bundle:nil];
    UIView *customView = [[nib instantiateWithOwner:nil options:nil] firstObject];
    
    DPLoadingButton *button = [[DPLoadingButton alloc] initWithCustomView:customView];
    [[button activityIndicatorView] setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [[button activityIndicatorView] setColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    
    [button setCenter:[[self view] center]];
    
    [button onButtonTap:^(DPLoadingButton *button){
        NSLog(@"custom view buton was tapped");
        [NSThread sleepForTimeInterval:2];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] init];
            [alertView setMessage:@"Go get your coffee."];
            [alertView addButtonWithTitle:@"I'm going"];
            [alertView show];
        });
    }];
    
    return button;
}


@end
