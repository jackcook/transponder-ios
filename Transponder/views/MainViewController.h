//
//  MainViewController.h
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface MainViewController : UIViewController<CLLocationManagerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *minutesTextField;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
