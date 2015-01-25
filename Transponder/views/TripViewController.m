//
//  TripViewController.m
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "TripViewController.h"

#define TIMESTAMP [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]].intValue

@implementation TripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect circleChartRect = CGRectMake(0, 0, 300, 300);
    
    self.circleChart = [[PNCircleChart alloc] initWithFrame:circleChartRect total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:20] clockwise:true shadow:false];
    self.circleChart.backgroundColor = [UIColor clearColor];
    self.circleChart.strokeColor = [UIColor whiteColor];
    self.circleChart.circleBackground.strokeColor = [UIColor colorWithRed:(4.0 / 255.0) green:(22.0 / 255.0) blue:(40.0 / 255.0) alpha:1].CGColor;
    
    [self.chartHolder addSubview:self.circleChart];
    
    self.circleChart.countingLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:32];
    self.circleChart.countingLabel.format = @"%d";
}

- (void)viewDidAppear:(BOOL)animated {
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserObjectID"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Users"];
    [query whereKey:@"objectId" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserObjectID"]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            int current = TIMESTAMP / 60;
            int last = (int) [query valueForKey:@"lastPing"] / 60;
            self.circleChart.current = [NSNumber numberWithInt:current - last];
            self.circleChart.total = [NSNumber numberWithInt:(int) [query valueForKey:@"pingInterval"]];
            [self.circleChart strokeChart];
        } else {
            NSLog(@"%@", error);
        }
    }];
}

- (IBAction)cancelButton:(id)sender {
    LAContext *context = [[LAContext alloc] init];
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Transponder needs Touch ID to verify it's you" reply:^(BOOL success, NSError *error) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
