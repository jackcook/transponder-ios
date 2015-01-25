//
//  PhoneViewController.m
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "PhoneViewController.h"

@interface PhoneViewController ()

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)animateLabelsOut {
    self.transponderHeight = 123;
    self.welcomeHeight = 79;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.welcomeLabel.frame = CGRectMake(self.welcomeLabel.frame.origin.x, self.welcomeLabel.frame.origin.y + 24, self.welcomeLabel.frame.size.width, self.welcomeLabel.frame.size.height);
        self.transponderLabel.frame = CGRectMake(self.transponderLabel.frame.origin.x, self.transponderLabel.frame.origin.y + 24, self.transponderLabel.frame.size.width, self.transponderLabel.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.75 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.welcomeLabel.frame = CGRectMake(self.welcomeLabel.frame.origin.x, -self.transponderHeight, self.welcomeLabel.frame.size.width, self.welcomeLabel.frame.size.height);
            self.transponderLabel.frame = CGRectMake(self.transponderLabel.frame.origin.x, -self.welcomeHeight, self.transponderLabel.frame.size.width, self.transponderLabel.frame.size.height);
        } completion:^(BOOL finished) {
            [self performSelector:@selector(animateLabelsIn) withObject:nil afterDelay:0.25];
            [self.welcomeLabel removeFromSuperview];
            [self.transponderLabel removeFromSuperview];
        }];
    }];
}

- (void)animateLabelsIn {
    self.startLabel = [[UILabel alloc] init];
    self.startLabel.text = @"To get started,";
    self.startLabel.textColor = [UIColor whiteColor];
    self.startLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:28.0];
    [self.startLabel sizeToFit];
    self.startLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, self.welcomeHeight, self.startLabel.frame.size.width, self.startLabel.frame.size.height);
    
    self.enterLabel = [[UILabel alloc] init];
    self.enterLabel.text = @"enter your phone number";
    self.enterLabel.textColor = [UIColor whiteColor];
    self.enterLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:28.0];
    [self.enterLabel sizeToFit];
    self.enterLabel.frame = CGRectMake(-self.enterLabel.frame.size.width, self.transponderHeight, self.enterLabel.frame.size.width, self.enterLabel.frame.size.height);
    
    self.enterLabel2 = [[UILabel alloc] init];
    self.enterLabel2.text = @"in the textbox below";
    self.enterLabel2.textColor = [UIColor whiteColor];
    self.enterLabel2.font = [UIFont fontWithName:@"Avenir-Roman" size:28.0];
    [self.enterLabel2 sizeToFit];
    self.enterLabel2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, self.transponderHeight + (self.transponderHeight - self.welcomeHeight), self.enterLabel2.frame.size.width, self.enterLabel2.frame.size.height);
    
    [self.view addSubview:self.startLabel];
    [self.view addSubview:self.enterLabel];
    [self.view addSubview:self.enterLabel2];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.startLabel.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - self.startLabel.frame.size.width) / 2, self.welcomeHeight, self.startLabel.frame.size.width, self.startLabel.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.enterLabel.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - self.enterLabel.frame.size.width) / 2, self.transponderHeight, self.enterLabel.frame.size.width, self.enterLabel.frame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.enterLabel2.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - self.enterLabel2.frame.size.width) / 2, self.transponderHeight + (self.transponderHeight - self.welcomeHeight), self.enterLabel2.frame.size.width, self.enterLabel2.frame.size.height);
            }  completion:^(BOOL finished) {
                self.phoneNumberEntry = [[UITextView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 5, self.enterLabel2.frame.origin.y + self.enterLabel2.frame.size.height + 36, [UIScreen mainScreen].bounds.size.width / 5 * 3, 54)];
                self.phoneNumberEntry.backgroundColor = [UIColor clearColor];
                self.phoneNumberEntry.alpha = 0;
                self.phoneNumberEntry.font = [UIFont fontWithName:@"Avenir-Roman" size:28.0];
                self.phoneNumberEntry.textColor = [UIColor whiteColor];
                self.phoneNumberEntry.textAlignment = NSTextAlignmentCenter;
                self.phoneNumberEntry.keyboardType = UIKeyboardTypePhonePad;
                
                CALayer *bottomBorder = [CALayer layer];
                bottomBorder.frame = CGRectMake(0, self.phoneNumberEntry.frame.size.height - 2, self.phoneNumberEntry.frame.size.width, 2);
                bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
                [self.phoneNumberEntry.layer addSublayer:bottomBorder];
                
                self.doneButton = [[UIButton alloc] init];
                self.doneButton.alpha = 0;
                [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
                [self.doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.doneButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                [self.doneButton sizeToFit];
                self.doneButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - self.doneButton.frame.size.width) / 2, self.phoneNumberEntry.frame.origin.y + self.phoneNumberEntry.frame.size.height + 48, self.doneButton.frame.size.width, self.doneButton.frame.size.height);
                [self.doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
                
                [self.view addSubview:self.phoneNumberEntry];
                [self.view addSubview:self.doneButton];
                
                [UIView animateWithDuration:0.5 animations:^{
                    self.phoneNumberEntry.alpha = 1;
                } completion:^(BOOL finished) {
                    [self.phoneNumberEntry becomeFirstResponder];
                    [UIView animateWithDuration:0.5 animations:^{
                        self.doneButton.alpha = 1;
                    }];
                }];
            }];
        }];
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.animated) {
        [self animateLabelsOut];
        self.animated = true;
    }
}

- (void)doneButtonPressed {
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
