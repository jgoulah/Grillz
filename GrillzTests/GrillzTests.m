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

- (void)testExample
{
    //XCTestLog(@"test");
    
              //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    NSLog(@"ran test");
    XCTAssertTrue(true, @"test ok");
}

- (void) notifyDone {
    
    [self notifyAsyncOperationDone];

}

-(void) notifyDoneWithData:(NSData*)data{
    [self notifyAsyncOperationDone];
    
    GrillStatus* gs = [[GrillStatus alloc]initWithData:data];
    NSLog(@"cook temp: %@", gs.cookTemp);
    
}

- (void)stubsOn {
    //NSArray* stubs = [NSArray arrayWithObjects:@"cyberq", nil];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
        //return [stubs containsObject:request.URL.absoluteString.lastPathComponent];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        
        NSString* file = [request.URL.absoluteString.lastPathComponent
                          stringByAppendingPathExtension:@"xml"];
        NSLog(@"file is %@", file);
        
        
        return [OHHTTPStubsResponse responseWithFile:file contentType:@"text/xml"
                                        responseTime:OHHTTPStubsDownloadSpeedEDGE];
    }];
}

- (void)testAFNetworking
{
    [self stubsOn];
    static const NSTimeInterval kResponseTime = 1.0;
    
    GrillNet* gn = [[GrillNet alloc] init];
    gn.delegate = self;
    [gn getGrillStatusWithURL:@"http://test/cyberq"];
    
    [self waitForAsyncOperationWithTimeout:kResponseTime+0.5];
    
    /*
    //NSArray* stubs = [NSArray arrayWithObjects:@"cyberq", nil];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
        //return [stubs containsObject:request.URL.absoluteString.lastPathComponent];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        
        NSString* file = [request.URL.absoluteString.lastPathComponent
                          stringByAppendingPathExtension:@"xml"];
        NSLog(@"file is %@", file);
    
    
        return [OHHTTPStubsResponse responseWithFile:file contentType:@"text/xml"
                                        responseTime:OHHTTPStubsDownloadSpeedEDGE];
    }];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFXMLParserResponseSerializer serializer]];
    //[manager GET:@"http://10.0.1.150/config.xml" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [manager GET:@"http://test/cyberq" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"XML: %@", responseObject);
        
        NSString* xml = operation.responseString;
        NSData* data = [xml dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"XML: %@", xml);
        
        RXMLElement *rootXML = [RXMLElement elementFromXMLData:data];
        NSLog(@"root tag %@", rootXML.tag);
        
        [rootXML iterate:@"COOK" usingBlock: ^(RXMLElement *cook) {
            NSLog(@"name: %@  cook temp%@)", [cook child:@"COOK_NAME"].text, [cook child:@"COOK_TEMP"].text);
        }];
        
        [self notifyAsyncOperationDone];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self notifyAsyncOperationDone];
    }];
    
    [self waitForAsyncOperationWithTimeout:kResponseTime+0.5];
    */
    
    
    /*
    NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.test.org/cyberq"]];
    

    __block AFXMLRequestOperation *operation =
    [AFXMLRequestOperation XMLParserRequestOperationWithRequest:req success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        [self notifyAsyncOperationDone];
        
        NSLog(@"!!!req wqas good and response is: %@", response);
        NSString *xml = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Raw XML Data: %@", xml);
        
        /////////////////
        /////////////////
        
        GrillStatus *gs = [[GrillStatus alloc] initWithXML:xml];
        
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
        XCTFail(@"Unexpected network failure");
        [self notifyAsyncOperationDone];

    }];
    [operation start];
    
    [self waitForAsyncOperationWithTimeout:kResponseTime+0.5];
    */
    
    NSLog(@"GOT HERE\n\n\n");
    
    
//    GrillNet* gn = [[GrillNet alloc]init];
//    NSString *xml = [GrillNet getGrillStatus];
    //GrillStatus *gs = [[GrillStatus alloc] initWithXML:xml];
    //XCTAssertEqual(response, expectedResponse, @"Unexpected data received");
    //XCTAssertTrue(response == expectedResponse, @"data doesn't match");
    
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"Did start element");
          if ( [elementName isEqualToString:@"root"])
          {
              NSLog(@"found rootElement");
              return;
          }
          }
          
          - (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
          {
              NSLog(@"Did end element");
              if ([elementName isEqualToString:@"root"])
              {
                  NSLog(@"rootelement end");
              }
              
          }
          - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
          {
              NSString *tagName = @"column";
              
              if([tagName isEqualToString:@"column"])
              {
                  NSLog(@"Value %@",string);
              }
              
          }


@end
