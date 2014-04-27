//
//  GrillNet.h
//  Grillz
//
//  Created by John Goulah on 4/27/14.
//  Copyright (c) 2014 John Goulah. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GrillNetActionProtocol <NSObject>
@optional
- (void)notifyDone;
- (void) notifyDoneWithData:(NSData*)data;
// ... other methods here
@end

@interface GrillNet : NSObject

-(void)getGrillStatusWithURL:(NSString*)url;

@property (nonatomic, assign) id  delegate;

@end
