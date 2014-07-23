//
//  DPLoadingButton+Helpers.m
//  Pods
//
//  Created by Petroianu Daniel on 7/23/14.
//
//

#import "DPLoadingButton+UIKit.h"

@implementation DPLoadingButton (UIKit)

- (UIBarButtonItem *)toBarButtonItem
{
    return [[UIBarButtonItem alloc] initWithCustomView:self];
}

@end
