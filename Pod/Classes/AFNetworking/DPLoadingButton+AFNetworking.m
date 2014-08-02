//
//  DPLoadingButton+AFNetworking.m
//  Pods
//
//  Created by Petroianu Daniel on 7/25/14.
//
//

#import "DPLoadingButton+AFNetworking.h"
#import <objc/runtime.h>

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import <AFNetworking/AFURLConnectionOperation.h>
static char RequestOperationButtonTapBlock;

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#import <AFNetworking/AFURLSessionManager.h>
static char NSURLSessionTaskButtonTapBlock;
#endif


@implementation DPLoadingButton (AFNetworking)

#pragma mark - AFURLConnectionOperation

- (void)startAnimatingWithRequestOperation:(DPLoadingButtonRequestOperationAction)block forControlEvents:(UIControlEvents)controlEvents{
    [self willChangeValueForKey:@"RequestOperationButtonTapBlock"];
    objc_setAssociatedObject(self, &RequestOperationButtonTapBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"RequestOperationButtonTapBlock"];
    
    [self addTarget:self action:@selector(dp_requestOperation_onButtonTap:) forControlEvents:controlEvents];
}

- (void)dp_requestOperation_onButtonTap:(id)sender {
    DPLoadingButtonRequestOperationAction block = objc_getAssociatedObject(self, &RequestOperationButtonTapBlock);
    if(block) {
        AFURLConnectionOperation *requestOperation = block(self);
        [self startAnimatingWithStateOfOperation:requestOperation];
    }
}

- (void)startAnimatingWithStateOfOperation:(AFURLConnectionOperation *)operation {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:AFNetworkingOperationDidStartNotification object:nil];
    [notificationCenter removeObserver:self name:AFNetworkingOperationDidFinishNotification object:nil];
    
    if (operation && ![operation isFinished]) {
        if ([operation isExecuting]) {
            [self startAnimating];
        } else {
            [self stopAnimating];
        }
        
        [notificationCenter addObserver:self selector:@selector(startAnimating) name:AFNetworkingOperationDidStartNotification object:operation];
        [notificationCenter addObserver:self selector:@selector(stopAnimating) name:AFNetworkingOperationDidFinishNotification object:operation];
    }
}


#pragma mark - NSURLSessionTask

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000

- (void)startAnimatingWithTask:(DPLoadingButtonURLSessionTaskAction)block forControlEvents:(UIControlEvents)controlEvents {
    [self willChangeValueForKey:@"NSURLSessionTaskButtonTapBlock"];
    objc_setAssociatedObject(self, &NSURLSessionTaskButtonTapBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"NSURLSessionTaskButtonTapBlock"];
    
    [self addTarget:self action:@selector(dp_sessionTask_onButtonTap:) forControlEvents:controlEvents];
}

- (void)dp_sessionTask_onButtonTap:(id)sender {
    DPLoadingButtonURLSessionTaskAction block = objc_getAssociatedObject(self, &NSURLSessionTaskButtonTapBlock);
    if(block) {
        NSURLSessionTask *task = block(self);
        [self startAnimatingWithStateOfTask:task];
    }
}

- (void)startAnimatingWithStateOfTask:(NSURLSessionTask *)task {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:AFNetworkingTaskDidResumeNotification object:nil];
    [notificationCenter removeObserver:self name:AFNetworkingTaskDidSuspendNotification object:nil];
    [notificationCenter removeObserver:self name:AFNetworkingTaskDidCompleteNotification object:nil];
    
    if (task && task.state != NSURLSessionTaskStateCompleted) {
        if (task.state == NSURLSessionTaskStateRunning) {
            [self startAnimating];
        } else {
            [self stopAnimating];
        }
        
        [notificationCenter addObserver:self selector:@selector(startAnimating) name:AFNetworkingTaskDidResumeNotification object:task];
        [notificationCenter addObserver:self selector:@selector(stopAnimating) name:AFNetworkingTaskDidCompleteNotification object:task];
        [notificationCenter addObserver:self selector:@selector(stopAnimating) name:AFNetworkingTaskDidSuspendNotification object:task];
    }
}

#endif

@end

@implementation DPLoadingButton (AFNetworking_Deprecated)

- (void)startRequestOperationOnButtonTap:(DPLoadingButtonRequestOperationAction)block
{
    [self startAnimatingWithRequestOperation:block forControlEvents:UIControlEventTouchUpInside];
}



#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000

- (void)startTaskOnButtonTap:(DPLoadingButtonURLSessionTaskAction)block {
    [self startAnimatingWithTask:block forControlEvents:UIControlEventTouchUpInside];
};

#endif

@end

#endif
