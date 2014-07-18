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
	
    DPLoadingButton *button = [[DPLoadingButton alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [button setBackgroundColor:[UIColor redColor]];
    [button startAnimating];
    [[self view] addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
