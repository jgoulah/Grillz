//
//  AsyncSenTestCase.h
//  Grillz
//
//  Created by John Goulah on 8/11/13.
//  Copyright (c) 2013 John Goulah. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface AsyncSenTestCase : XCTestCase

-(void)waitForAsyncOperationWithTimeout:(NSTimeInterval)timeout; //!< Wait for one async operation
-(void)waitForAsyncOperations:(NSUInteger)count withTimeout:(NSTimeInterval)timeout; //!< Wait for multiple async operations
-(void)waitForTimeout:(NSTimeInterval)timeout; //!< Wait for a fixed amount of time
-(void)notifyAsyncOperationDone; //!< notify any waiter that the async op is done

@end
