//
//  Common.m
//  Transponder
//
//  Created by Jack Cook on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "Common.h"

@implementation Common

@synthesize setupPhoneNumber;
@synthesize setupEmergencyContacts;

@synthesize venue;
@synthesize deviceToken;
@synthesize needToConfirm;

static Common *instance = nil;

+ (Common *)sharedInstance {
    @synchronized(self) {
        if (instance == nil) {
            instance = [Common new];
        }
    }
    
    return instance;
}

@end
