//
//  DPViewController.m
//  DPLoadingButton
//
//  Created by Petroianu Daniel on 07/18/2014.
//  Copyright (c) 2014 Petroianu Daniel. All rights reserved.
//

#import "DPViewController.h"
#import "DPDetailsViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface DPViewController () {
    AFHTTPRequestOperationManager *_reqManager;
}
@property(nonatomic, strong) NSArray *dummyData;
@end

@implementation DPViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSURL *baseUrl = [NSURL URLWithString:@"http://filltext.com/"];
        _reqManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
        _dummyData = [[NSArray alloc] initWithObjects:
                      @"Espresso",
                      @"Cappuccino",
                      @"Americano",
                      @"Caffe Latte",
                      @"Caf au Lait",
                      @"Caf Mocha (Mochachino)",
                      @"Caramel Macchiato", nil];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationItem] setLeftBarButtonItem:[self createLoadingBarButtonItemWithText]];
	[[self navigationItem] setRightBarButtonItem:[self createLoadingBarButtonItemWithImage]];
}

#pragma mark - 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self dummyData] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    [[cell textLabel] setText:[[self dummyData] objectAtIndex:[indexPath row]]];
    
    UIImage *image = [UIImage imageNamed:@"coffee"];
    DPLoadingButton *disclosure = [[DPLoadingButton alloc] initWithImage:image];
    [[disclosure activityIndicatorView] setColor:[UIColor grayColor]];
    
    [disclosure addTarget:self action:@selector(dpLoadingButton_manualy_animated:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell setAccessoryView:disclosure];
    
    return cell;
}


#pragma mark -

- (UIBarButtonItem *)createLoadingBarButtonItemWithText {
    // Example of DPLoadingButton created with text
    
    NSString *title = @"work";
    DPLoadingButton *leftButton = [[DPLoadingButton alloc] initWithTitle:title];
    [[leftButton titleLable] setTextColor:[UIColor redColor]];
    [[leftButton activityIndicatorView] setColor:[UIColor redColor]];
    
    [leftButton addAction:^(DPLoadingButton *button) {
        NSLog(@"left button was tapped %@", button);
        [NSThread sleepForTimeInterval:0.5];
    } forControlEvents:UIControlEventTouchUpInside];
    
    return [leftButton toBarButtonItem];
}

- (UIBarButtonItem *)createLoadingBarButtonItemWithImage {
    // Example of DPLoadingButton created with image
    
    UIImage *image = [UIImage imageNamed:@"coffee"];
    DPLoadingButton *rightButton = [[DPLoadingButton alloc] initWithImage:image];
    [[rightButton activityIndicatorView] setColor:[UIColor blackColor]];
    
    [rightButton addAction:^(DPLoadingButton *button){
        
        NSLog(@"right button was tapped %@", button);
        [NSThread sleepForTimeInterval:2];
        
    } withCompletion:^(DPLoadingButton *button){
        
        NSLog(@"right button finished running action %@", button);
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    return [rightButton toBarButtonItem];
}

- (void)dpLoadingButton_manualy_animated:(DPLoadingButton *)sender {
    NSLog(@"manualy animating button %@", sender);
    [[_reqManager operationQueue] cancelAllOperations];
    [sender startAnimating];
    
    NSDictionary *params = @{ @"rows": @1, @"delay": @1 };

    [_reqManager GET:@"/" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [sender stopAnimating];
        [self performSegueWithIdentifier:@"ShowDetailsSegue" sender:sender];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [sender stopAnimating];
    
    }];
}

@end
