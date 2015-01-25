//
//  PhoneViewController.h
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Common.h"

@interface PhoneViewController : UIViewController<UITextViewDelegate>

@property (nonatomic) int transponderHeight;
@property (nonatomic) int welcomeHeight;

@property (nonatomic) BOOL animated;

@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *transponderLabel;

@property (strong, nonatomic) UILabel *startLabel;
@property (strong, nonatomic) UILabel *enterLabel;
@property (strong, nonatomic) UILabel *enterLabel2;

@property (strong, nonatomic) UITextView *phoneNumberEntry;
@property (strong, nonatomic) UIButton *doneButton;

@end
