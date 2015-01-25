//
//  Common.h
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+ (Common *)sharedInstance;

@property (nonatomic) int setupPhoneNumber;
@property (strong, nonatomic) NSArray *setupEmergencyContacts;

@property (strong, nonatomic) NSDictionary *venue;
@property (strong, nonatomic) NSString *deviceToken;

@end
