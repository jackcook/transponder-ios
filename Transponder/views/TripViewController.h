//
//  TripViewController.h
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "PNChart.h"
#import "MBProgressHUD.h"
#import <Parse/Parse.h>
#import "MainViewController.h"

@interface TripViewController : UIViewController

@property (nonatomic) NSNumber *current;
@property (nonatomic) NSNumber *total;
@property (nonatomic) int minutes;
@property (nonatomic) BOOL displayingTouchID;

@property (strong, nonatomic) PNCircleChart *circleChart;

@property (strong, nonatomic) IBOutlet UIView *chartHolder;
@property (strong, nonatomic) IBOutlet UILabel *pingLabel;

@property (strong, nonatomic) NSTimer *updateTimer;
@property (strong, nonatomic) NSTimer *chartTimer;

@end
