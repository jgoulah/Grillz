//
//  AsyncSenTestCase.m
//  Grillz
//
//  Created by John Goulah on 8/11/13.
//  Copyright (c) 2013 John Goulah. All rights reserved.
//

#import "AsyncSenTestCase.h"

@interface AsyncSenTestCase()
@property(atomic, assign) NSUInteger asyncTestCaseSignaledCount;
@end

static const NSTimeInterval kRunLoopSamplingInterval = 0.01;



@implementation AsyncSenTestCase
@synthesize asyncTestCaseSignaledCount = _asyncTestCaseSignaledCount;

-(void)waitForAsyncOperationWithTimeout:(NSTimeInterval)timeout
{
    [self waitForAsyncOperations:1 withTimeout:timeout];
}

-(void)waitForAsyncOperations:(NSUInteger)count withTimeout:(NSTimeInterval)timeout
{
    NSDate* timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeout];
    while ((self.asyncTestCaseSignaledCount < count) && ([timeoutDate timeIntervalSinceNow]>0))
    {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, kRunLoopSamplingInterval, YES);
    }
    
    // Reset the counter for next time, in case we call this method again later
    // (don't reset it at the beginning of the method because we should be able to call
    // notifyAsyncOperationDone *before* this method if we wanted to)
    self.asyncTestCaseSignaledCount = 0;
    
    if ([timeoutDate timeIntervalSinceNow]<0)
    {
        // now is after timeoutDate, we timed out
        XCTFail(@"Timed out while waiting for Async Operations to finish.");
    }
}

-(void)waitForTimeout:(NSTimeInterval)timeout
{
    NSDate* waitEndDate = [NSDate dateWithTimeIntervalSinceNow:timeout];
    while ([waitEndDate timeIntervalSinceNow]>0)
    {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, kRunLoopSamplingInterval, YES);
    }
}

-(void)notifyAsyncOperationDone
{
    @synchronized(self)
    {
        self.asyncTestCaseSignaledCount = self.asyncTestCaseSignaledCount+1;
    }
}

@end
