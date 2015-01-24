//
//  PhoneViewController.h
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *transponderLabel;

@property (strong, nonatomic) UILabel *startLabel;
@property (strong, nonatomic) UILabel *enterLabel;

@end
