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
    
    NSArray *emergencyContacts = [Common sharedInstance].setupEmergencyContacts;
    NSMutableArray *emergencyContactNumbers = [NSMutableArray array];
    
    for (int i = 0; i < emergencyContacts.count; i++) {
        APContact *contact = [emergencyContacts objectAtIndex:i];
        [emergencyContactNumbers addObject:contact.phones[0]];
    }
    
    NSString *contactsString = [emergencyContactNumbers componentsJoinedByString:@","];
    
    PFObject *EmergencyContactObject = [PFObject objectWithClassName:@"EmergencyContact"];
    EmergencyContactObject[@"emergencyContacts"] = [[[[contactsString stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    [EmergencyContactObject saveInBackground];

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
