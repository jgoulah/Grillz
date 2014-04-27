//
//  GrillStatus.m
//  Grillz
//
//  Created by John Goulah on 8/17/13.
//  Copyright (c) 2013 John Goulah. All rights reserved.
//

#import "GrillStatus.h"
#import "RXMLElement.h"

@implementation GrillStatus

-(id)initWithData:(NSData *)data {
    self = [super init];
    
    RXMLElement *rootXML = [RXMLElement elementFromXMLData:data];
    
    [rootXML iterate:@"COOK" usingBlock: ^(RXMLElement *cook) {
        _cookTemp = [[cook child:@"COOK_TEMP"].text intValue];
        _cookTemp /= 10;
        
        _cookSet = [[cook child:@"COOK_SET"].text intValue];
        _cookSet /= 10;
    }];
    
   
    
    return self;
}

@end
