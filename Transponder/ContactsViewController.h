//
//  ContactsViewController.h
//  Transponder
//
//  Created by Jacob Banks on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ContactsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    NSMutableArray *RetrievedNamesMutableArray;

    IBOutlet UITableView *tableview;
}

@end
