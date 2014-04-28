//
//  GrillzTests.m
//  GrillzTests
//
//  Created by John Goulah on 7/27/13.
//  Copyright (c) 2013 John Goulah. All rights reserved.
//

//#import <XCTest/XCTest.h>
#import "AsyncSenTestCase.h"
#import "AFHTTPRequestOperationManager.h"
#import "OHHTTPStubs.h"
#import "GrillStatus.h"
#import "RXMLElement.h"
#import "GrillNet.h"
#import "GrillStatus.h"


@interface GrillzTests : AsyncSenTestCase <GrillNetActionProtocol>

@property (nonatomic, copy) GrillStatus* gs;

@end

@implementation GrillzTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void) notifyDone {
    
    [self notifyAsyncOperationDone];

}

-(void) notifyDoneWithData:(NSData*)data{
    [self notifyAsyncOperationDone];
    
    _gs = [[GrillStatus alloc]initWithData:data];
    NSLog(@"cook temp: %ld", [_gs cookTemp]);
    
}

- (void)testGetCyberQStatus
{
    static const NSTimeInterval kResponseTime = 1.0;
    
    GrillNet* gn = [[GrillNet alloc] init];
    [gn stubsOn];
    gn.delegate = self;
    [gn getGrillStatusWithURL:@"http://test/cyberq"];
    
    [self waitForAsyncOperationWithTimeout:kResponseTime+0.5];
    
    XCTAssertTrue(_gs.cookTemp == 390, @"cook temp 390 and was %ld",_gs.cookTemp);
}


@end
