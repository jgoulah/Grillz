//
//  GrillNet.m
//  Grillz
//
//  Created by John Goulah on 4/27/14.
//  Copyright (c) 2014 John Goulah. All rights reserved.
//

#import "GrillNet.h"
#import "AFHTTPRequestOperationManager.h"
#import "RXMLElement.h"
#import "OHHTTPStubs.h"

@implementation GrillNet

- (id) init {
    self = [super init];
    
    return self;
}


- (void)stubsOn {

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        
//        NSString* file = [request.URL.absoluteString.lastPathComponent
//                          stringByAppendingPathExtension:@"xml"];
        NSString* file = @"cyberq.xml";
        NSLog(@"file is %@", file);
        
        
        return [OHHTTPStubsResponse responseWithFile:file contentType:@"text/xml"
                                        responseTime:OHHTTPStubsDownloadSpeedEDGE];
    }];
 
 
}


-(void)getGrillStatusWithURL:(NSString*)url {
    [self stubsOn];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFXMLParserResponseSerializer serializer]];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString* xml = operation.responseString;
        NSData* data = [xml dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"XML: %@\n\n", xml);
        
        if([[self delegate] respondsToSelector:@selector(notifyDoneWithData:)]) {
            [[self delegate] notifyDoneWithData:data];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if([[self delegate] respondsToSelector:@selector(notifyDone)]) {
            [[self delegate] notifyDone];
        }
    }];
    
}

@end
