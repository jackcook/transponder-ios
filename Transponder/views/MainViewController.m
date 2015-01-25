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
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.minutesTextField.isFirstResponder) {
        [self.minutesTextField resignFirstResponder];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
