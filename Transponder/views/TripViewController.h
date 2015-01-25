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

@interface TripViewController : UIViewController

@property (strong, nonatomic) PNCircleChart *circleChart;

@property (strong, nonatomic) IBOutlet UIView *chartHolder;

@end
