//
//  PitTempViewController.h
//  Grillz
//
//  Created by John Goulah on 7/27/13.
//  Copyright (c) 2013 John Goulah. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GrillNet.h"

@class GrillStatus;

@interface PitTempViewController : UIViewController <GrillNetActionProtocol>




@property (nonatomic, copy) GrillStatus* grillstatus;
@property (nonatomic, copy) GrillNet* grillNet;

@property (nonatomic, copy) UILabel* tempatureLabel;

@end
