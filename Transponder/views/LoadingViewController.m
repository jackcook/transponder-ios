//
//  LoadingViewController.m
//  Transponder
//
//  Created by Jack Cook on 1/25/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "LoadingViewController.h"

#define TIMESTAMP [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]].intValue

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UserObjectID"] != nil) {
        PFQuery *query = [PFQuery queryWithClassName:@"Users"];
        [query whereKey:@"objectId" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserObjectID"]];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (error) {
                [self performSegueWithIdentifier:@"welcomeSegue" sender:self];
            } else {
                if ([[object objectForKey:@"onTrip"] boolValue]) {
                    int current = TIMESTAMP / 60;
                    int last = [[object valueForKey:@"lastPing"] intValue] / 60;
                    self.current = [NSNumber numberWithInt:[[object objectForKey:@"pingInterval"] intValue] - (current - last)];
                    self.total = [NSNumber numberWithInteger:[[object objectForKey:@"pingInterval"] intValue]];
                    
                    self.minutes = 50 / ([[object objectForKey:@"pingInterval"] intValue]) * ([[object objectForKey:@"pingInterval"] intValue] - (current - last));
                    
                    [self performSegueWithIdentifier:@"tripSegue" sender:self];
                } else {
                    [self performSegueWithIdentifier:@"mainSegue" sender:self];
                }
            }
        }];
    } else {
        [self performSegueWithIdentifier:@"welcomeSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"tripSegue"]) {
        TripViewController *tvc = (TripViewController *)segue.destinationViewController;
        tvc.current = self.current;
        tvc.total = self.total;
        tvc.minutes = self.minutes;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
