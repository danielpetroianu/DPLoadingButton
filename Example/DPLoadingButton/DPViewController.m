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

@end

@implementation DPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    DPLoadingButton *button = [[DPLoadingButton alloc] initWithTitle:@"ceva mare"];
    [button setCenter:[[self view] center]];
    [[button activityIndicatorView] setColor:[UIColor redColor]];
//    [button setBackgroundColor:[UIColor redColor]];
    
    
    [button setOnButtonTap:^(DPLoadingButton *button){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"button was tapped");
            [NSThread sleepForTimeInterval:5];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [button stopAnimating];
            });
        });
    }];
    
    
    
//    [[self view] addSubview:button];
    
    [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:button]];
}

@end
