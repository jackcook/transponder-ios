//
//  DoneViewController.m
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "DoneViewController.h"

@interface DoneViewController ()

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *emergencyContacts = [Common sharedInstance].setupEmergencyContacts;
    NSMutableArray *emergencyContactNumbers = [NSMutableArray array];
    
    for (int i = 0; i < emergencyContacts.count; i++) {
        APContact *contact = [emergencyContacts objectAtIndex:i];
        [emergencyContactNumbers addObject:contact.phones[0]];
    }
    
    NSString *contactsString = [emergencyContactNumbers componentsJoinedByString:@","];
    
    PFObject *userObject = [PFObject objectWithClassName:@"Users"];
    userObject[@"contacts"] = [[[[[contactsString stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    userObject[@"phoneNumber"] = [NSNumber numberWithInt:[Common sharedInstance].setupPhoneNumber];
    userObject[@"deviceToken"] = [Common sharedInstance].deviceToken;
    [userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [[NSUserDefaults standardUserDefaults] setObject:userObject.objectId forKey:@"UserObjectID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    MainViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self presentViewController:mvc animated:true completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
