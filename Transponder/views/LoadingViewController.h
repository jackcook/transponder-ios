//
//  LoadingViewController.h
//  Transponder
//
//  Created by Jack Cook on 1/25/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TripViewController.h"

@interface LoadingViewController : UIViewController

@property (nonatomic) NSNumber *current;
@property (nonatomic) NSNumber *total;
@property (nonatomic) int minutes;

@end
