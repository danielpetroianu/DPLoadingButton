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
	
    DPLoadingButton *button = [[DPLoadingButton alloc] initWithTitle:@"do something"];
    [[button activityIndicatorView] setColor:[UIColor blackColor]];
    
    [button setOnButtonTap:^(DPLoadingButton *button){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"button was tapped");
            [NSThread sleepForTimeInterval:5];
            
            [button stopAnimating];
        });
    }];
    
    [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:button]];
}

@end
