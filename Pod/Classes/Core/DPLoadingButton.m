//
//  DPLoadingButton.m
//  Pods
//
//  Created by Petroianu Daniel on 7/18/14.
//
//

#import "DPLoadingButton.h"

#define dp_dispatch_main_async_safe(block)\
        if ([NSThread isMainThread]) {\
            block();\
        } else {\
            dispatch_async(dispatch_get_main_queue(), block);\
        }

@interface DPLoadingButton () {
    NSMutableDictionary *_actions;
    NSMutableDictionary *_completionHandlers;
    UIControlEvents _currentUIControlEvent;
}

@property(nonatomic, strong, readwrite) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic, strong, readwrite) UILabel *titleLable;

@property(nonatomic, weak) UIView *buttonView;

@property(nonatomic, readonly) NSMutableDictionary *actions;
@property(nonatomic, readonly) NSMutableDictionary *completionHandlers;

@end

@implementation DPLoadingButton


#pragma mark - Life Cycle

- (instancetype)initWithImage:(UIImage *)image
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    
    return [self initWithCustomView:imgView];
}

- (instancetype)initWithTitle:(NSString *)title
{
    [self setTitleLable:[[UILabel alloc] initWithFrame:CGRectZero]];
    [[self titleLable] setBackgroundColor:[UIColor clearColor]];
    [[self titleLable] setText:title];
    [[self titleLable] sizeToFit];
    
    return [self initWithCustomView:[self titleLable]];
}

- (instancetype)initWithCustomView:(UIView *)view
{
    if(self = [self initWithFrame:[view frame]])
    {
        [view setUserInteractionEnabled:NO];
        [self addSubview:view];
        [self setButtonView:view];

        [self createSubviews];
    }
    
    return self;
}

- (void)layoutSubviews
{
    CGRect frame = [self frame];
    
    [[self activityIndicatorView] setCenter:CGPointMake(frame.size.width/2, frame.size.height/2)];
}


#pragma mark - Properties

- (void)startAnimating
{
    dp_dispatch_main_async_safe(^{
        [[self activityIndicatorView] setAlpha:0.0];
        [[self activityIndicatorView] startAnimating];
        
        [UIView animateWithDuration:0.5 animations:^{
            [[self buttonView] setAlpha:0.2];
            [[self activityIndicatorView] setAlpha:1.0];
        }];
    });
}

- (void)stopAnimating
{
    dp_dispatch_main_async_safe(^{
        [[self activityIndicatorView] stopAnimating];
        
        [UIView animateWithDuration:0.3 animations:^{
            [[self buttonView] setAlpha:1];
        }];
    });
}

#pragma mark - Methods

- (void)addAction:(DPLoadingButtonAction)action
{
    [self addAction:action withCompletion:nil forControlEvents:UIControlEventTouchUpInside];
}

- (void)addAction:(DPLoadingButtonAction)action forControlEvents:(UIControlEvents)controlEvents
{
    [self addAction:action withCompletion:nil forControlEvents:controlEvents];
}

- (void)addAction:(DPLoadingButtonAction)action withCompletion:(DPLoadingButtonCompletionHandler)completionHandler
{
    [self addAction:action withCompletion:completionHandler forControlEvents:UIControlEventTouchUpInside];
}

- (void)addAction:(DPLoadingButtonAction)action withCompletion:(DPLoadingButtonCompletionHandler)completionHandler forControlEvents:(UIControlEvents)controlEvents
{
    NSParameterAssert(action);
    NSParameterAssert(controlEvents);
    
    NSArray *keys = [self keysForControlEvents:controlEvents];
    for (NSString *key in keys) {
        [[self actions] setObject:action forKey:key];
        
        if(completionHandler) {
            [[self completionHandlers] setObject:completionHandler forKey:key];
        }
    }
    
    [self captureEvents:controlEvents];
    [self addTarget:self action:@selector(buttonWasTapped:) forControlEvents:controlEvents];
}

- (void)removeAllActions
{
    [[self actions] removeAllObjects];
    [[self completionHandlers] removeAllObjects];
    
    [self removeTarget:nil action:NULL forControlEvents:UIControlEventAllTouchEvents];
}

- (void)removeActionForControlEvents:(UIControlEvents)controlEvents
{
    NSArray *keys = [self keysForControlEvents:controlEvents];
    for (NSString *key in keys) {
        [[self actions] removeObjectForKey:key];
        [[self completionHandlers] removeObjectForKey:key];
    }
    
    [self removeTarget:nil action:NULL forControlEvents:controlEvents];
}

#pragma mark - Helpers

- (void)createSubviews {
    [self setActivityIndicatorView:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]];
    [self addSubview:[self activityIndicatorView]];
}

- (NSArray *)keysForControlEvents:(UIControlEvents)controlEvents
{
    NSMutableArray *keys = [NSMutableArray array];
    
    [self forEachUIControlEventDo:^(UIControlEvents event) {
        if(event & controlEvents)
            [keys addObject:[self keyForControlEvent:event]];
    }];

    return [NSArray arrayWithArray:keys];
}

- (NSString *)keyForControlEvent:(UIControlEvents)controlEvents
{
    return [NSString stringWithFormat:@"%d", (NSUInteger)controlEvents];
}

- (void)buttonWasTapped:(id) sender
{
    NSString *key = [self keyForControlEvent:_currentUIControlEvent];
    
    if([[self actions] objectForKey:key]){
        [self setEnabled:NO];
        [self startAnimating];
        
        __weak typeof(self) wSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            DPLoadingButtonAction actionBlock = [[wSelf actions] objectForKey:key];
            actionBlock(wSelf);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [wSelf stopAnimating];
                [wSelf setEnabled:YES];
                
                DPLoadingButtonCompletionHandler completionHandler = [[wSelf completionHandlers] objectForKey:key];
                if(completionHandler) {
                    completionHandler(wSelf);
                }
            });
        });
    }
}

- (NSMutableDictionary *)actions
{
    return _actions ?: (_actions = [NSMutableDictionary dictionary]);
}

- (NSMutableDictionary *)completionHandlers
{
    return _completionHandlers ?: (_completionHandlers = [NSMutableDictionary dictionary]);
}

- (void)forEachUIControlEventDo:(void (^)(UIControlEvents event))block
{
    for (UIControlEvents event = UIControlEventTouchDown; event < UIControlEventAllTouchEvents; event <<= 1) {
        block(event);
    }
}

#pragma mark - https://gist.github.com/jbenet/513796

- (void) captureUIControlEventTouchDown {
    _currentUIControlEvent = UIControlEventTouchDown;
}

- (void) captureUIControlEventTouchDownRepeat {
    _currentUIControlEvent = UIControlEventTouchDownRepeat;
}

- (void) captureUIControlEventTouchDragInside {
    _currentUIControlEvent = UIControlEventTouchDragInside;
}

- (void) captureUIControlEventTouchDragOutside {
    _currentUIControlEvent = UIControlEventTouchDragOutside;
}

- (void) captureUIControlEventTouchDragEnter {
    _currentUIControlEvent = UIControlEventTouchDragEnter;
}

- (void) captureUIControlEventTouchDragExit {
    _currentUIControlEvent = UIControlEventTouchDragExit;
}

- (void) captureUIControlEventTouchUpInside {
    _currentUIControlEvent = UIControlEventTouchUpInside;
}

- (void) captureUIControlEventTouchUpOutside {
    _currentUIControlEvent = UIControlEventTouchUpOutside;
}

- (void) captureUIControlEventTouchCancel {
    _currentUIControlEvent = UIControlEventTouchCancel;
}

- (void) captureUIControlEventValueChanged {
    _currentUIControlEvent = UIControlEventValueChanged;
}

- (SEL) captureActionForUIControlEvent:(UIControlEvents)controlEvent
{
    switch (controlEvent) {
        case UIControlEventTouchDown:
            return @selector(captureUIControlEventTouchDown);
        case UIControlEventTouchDownRepeat:
            return @selector(captureUIControlEventTouchDownRepeat);
        case UIControlEventTouchDragInside:
            return @selector(captureUIControlEventTouchDragInside);
        case UIControlEventTouchDragOutside:
            return @selector(captureUIControlEventTouchDragOutside);
        case UIControlEventTouchDragEnter:
            return @selector(captureUIControlEventTouchDragEnter);
        case UIControlEventTouchDragExit:
            return @selector(captureUIControlEventTouchDragExit);
        case UIControlEventTouchUpInside:
            return @selector(captureUIControlEventTouchUpInside);
        case UIControlEventTouchUpOutside:
            return @selector(captureUIControlEventTouchUpOutside);
        case UIControlEventTouchCancel:
            return @selector(captureUIControlEventTouchCancel);
        case UIControlEventValueChanged:
            return @selector(captureUIControlEventValueChanged);
        default:
            return nil;
    }
}

- (void) considerCapturing:(UIControlEvents)event forControlEvents:(UIControlEvents)controlEvents
{
    SEL captureAction = [self captureActionForUIControlEvent:event];
    if ((controlEvents & event) && captureAction != nil) {
        [self addTarget:self action:captureAction forControlEvents:event];
    }
}

- (void) captureEvents:(UIControlEvents)events {
    [self forEachUIControlEventDo:^(UIControlEvents event) {
         [self considerCapturing:event forControlEvents:events];
    }];
}

@end


@implementation DPLoadingButton (UIKit)

- (UIBarButtonItem *)toBarButtonItem
{
    return [[UIBarButtonItem alloc] initWithCustomView:self];
}

@end


@implementation DPLoadingButton (Deprecated)

- (void)onButtonTap:(DPLoadingButtonAction)block
{
    [self addAction:block withCompletion:nil forControlEvents:UIControlEventTouchUpInside];
}

@end