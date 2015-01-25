//
//  MainViewController.h
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *minutesTextField;

@end
