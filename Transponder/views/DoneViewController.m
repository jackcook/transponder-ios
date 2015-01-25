//
//  DoneViewController.m
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "DoneViewController.h"

@interface DoneViewController ()

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = locations.lastObject;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self performSegueWithIdentifier:@"mainSegue" sender:self];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
