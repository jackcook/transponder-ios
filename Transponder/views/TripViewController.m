//
//  TripViewController.m
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "TripViewController.h"

@implementation TripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect circleChartRect = CGRectMake(0, 0, 300, 300);
    
    self.circleChart = [[PNCircleChart alloc] initWithFrame:circleChartRect total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:60] clockwise:true shadow:false];
    self.circleChart.backgroundColor = [UIColor clearColor];
    self.circleChart.strokeColor = [UIColor whiteColor];
    self.circleChart.circleBackground.strokeColor = [UIColor colorWithRed:(4.0 / 255.0) green:(22.0 / 255.0) blue:(40.0 / 255.0) alpha:1].CGColor;
    
    [self.chartHolder addSubview:self.circleChart];
    
    [self.circleChart strokeChart];
    
    self.circleChart.countingLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:32];
    self.circleChart.countingLabel.format = @"%d";
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
