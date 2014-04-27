//
//  PitTempViewController.m
//  Grillz
//
//  Created by John Goulah on 7/27/13.
//  Copyright (c) 2013 John Goulah. All rights reserved.
//

#import "PitTempViewController.h"
#import "GrillNet.h"
#import "GrillStatus.h"

@interface PitTempViewController ()

@end

@implementation PitTempViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _grillNet = [[GrillNet alloc]init];
        _grillNet.delegate = self;
        [_grillNet getGrillStatusWithURL:@"http://10.0.1.150/config.xml"];
        
        [NSTimer scheduledTimerWithTimeInterval:5.0
                                         target:self
                                       selector:@selector(updateUIElements)
                                       userInfo:nil
                                        repeats:YES];
    }
    return self;
}

-(void) updateUIElements {
    NSLog(@"!!updateUIElements");
    [_grillNet getGrillStatusWithURL:@"http://10.0.1.150/config.xml"];
    
    //Accessing UI Thread
    /*
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        //Do any updates to your label here
        yourLabel.text = newText;
        
    }];
     */
}

-(void) notifyDoneWithData:(NSData*)data{
    
    _grillstatus = [[GrillStatus alloc]initWithData:data];
    NSLog(@"cook temp: %ld", _grillstatus.cookTemp);
    
    _tempatureLabel.text = [NSString stringWithFormat:@"%ld", _grillstatus.cookTemp];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"Grill Stats";
    
    _tempatureLabel = [[UILabel alloc] init];
    _tempatureLabel.frame = CGRectMake(75, 200, 200, 100);
    UIColor* color = [UIColor colorWithRed:0.4 green:0.8 blue:0.9 alpha:0.8];
    _tempatureLabel.backgroundColor = color;
    _tempatureLabel.text = @"0";
    [self.view addSubview:_tempatureLabel];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
