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
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)viewDidAppear:(BOOL)animated {
    self.circleChart.current = self.current;
    self.circleChart.total = self.total;
    [self.circleChart strokeChart];
    
    self.circleChart.countingLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:42];
    self.circleChart.countingLabel.format = @"%d";
    
    self.pingLabel.text = [NSString stringWithFormat:@"You will be pinged in %d minutes", self.minutes];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    NSTimer *chartTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(updateChart) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:chartTimer forMode:NSRunLoopCommonModes];
}

- (void)updateChart {
    self.circleChart.duration = 2;
    [self.circleChart updateChartByCurrent:self.current];
}

- (void)updateTimer {
    PFQuery *query = [PFQuery queryWithClassName:@"Users"];
    [query whereKey:@"objectId" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserObjectID"]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSLog(@"%@, %d", object[@"lastResponse"], TIMESTAMP);
        double minutes = (double) (TIMESTAMP - [object[@"lastResponse"] intValue]);
        minutes /= 60.0;
        NSLog(@"%f", minutes);
        self.current = [NSNumber numberWithDouble:self.total.intValue - minutes];
    }];
    
    if ([Common sharedInstance].needToConfirm) {
        self.pingLabel.text = @"You need to confirm you're OK";
        [Common sharedInstance].needToConfirm = NO;
        
        LAContext *context = [[LAContext alloc] init];
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Transponder needs Touch ID to verify your identity" reply:^(BOOL success, NSError *error) {
            if (success) {
                PFQuery *query = [PFQuery queryWithClassName:@"Users"];
                [query whereKey:@"objectId" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserObjectID"]];
                [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                    object[@"lastResponse"] = [NSNumber numberWithInt:TIMESTAMP];
                    [object saveInBackground];
                }];
            }
        }];
    } else {
        self.pingLabel.text = [NSString stringWithFormat:@"You will be pinged in %@ minutes", self.circleChart.countingLabel.text];
    }
}

- (IBAction)cancelButton:(id)sender {
    LAContext *context = [[LAContext alloc] init];
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Transponder needs Touch ID to verify your identity" reply:^(BOOL success, NSError *error) {
        if (success) {
            MainViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            [self presentViewController:mvc animated:YES completion:nil];
            
            PFQuery *query = [PFQuery queryWithClassName:@"Users"];
            [query whereKey:@"objectId" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserObjectID"]];
            [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                object[@"onTrip"] = [NSNumber numberWithBool:NO];
                [object saveInBackground];
            }];
        }
    }];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
