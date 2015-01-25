//
//  DoneViewController.h
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Common.h"
#import <Parse/Parse.h>
#import "APContact.h"
#import "MainViewController.h"

@interface DoneViewController : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end
