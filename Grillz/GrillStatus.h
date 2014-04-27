//
//  GrillStatus.h
//  Grillz
//
//  Created by John Goulah on 8/17/13.
//  Copyright (c) 2013 John Goulah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrillStatus : NSObject

@property (nonatomic) NSInteger cookTemp;
@property (nonatomic) NSInteger cookSet;
@property (nonatomic) NSInteger Food1Temp;
@property (nonatomic) NSInteger Food1Set;
@property (nonatomic) NSInteger Food2Temp;
@property (nonatomic) NSInteger Food2Set;
@property (nonatomic) NSInteger Food3Temp;
@property (nonatomic) NSInteger Food3Set;


-(id)initWithData:(NSData *)data;

@end
