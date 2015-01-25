//
//  MainViewController.m
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.minutesTextField.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = locations.lastObject;
    self.latitude = location.coordinate.latitude;
    self.longitude = location.coordinate.longitude;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.minutesTextField.isFirstResponder) {
        [self.minutesTextField resignFirstResponder];
    }
}

- (IBAction)startTripPressed:(id)sender {
    [self performSegueWithIdentifier:@"tripSegue" sender:self];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserObjectID"];
    NSLog(@"%@", userID);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Users"];
    [query whereKey:@"objectId" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserObjectID"]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        object[@"latitude"] = @(self.latitude);
        object[@"longitude"] = @(self.longitude);
        [object saveInBackground];
    }];
    
    [self.locationManager stopUpdatingLocation];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
