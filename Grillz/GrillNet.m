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

@implementation GrillNet

- (id) init {
    self = [super init];
    
    return self;
}

-(void)getGrillStatusWithURL:(NSString*)url {
    
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
