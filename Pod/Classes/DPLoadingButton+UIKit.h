//
//  DPLoadingButton+Helpers.h
//  Pods
//
//  Created by Petroianu Daniel on 7/23/14.
//
//

#import <UIKit/UIKit.h>
#import "DPLoadingButton.h"

@interface DPLoadingButton (UIKit)

/**
 Helper method that will return an UIBarButtonItem.
 
 @return A UIBarButtonItem with this DPLoadingButton as it's view.
 */
- (UIBarButtonItem *)toBarButtonItem;

@end
