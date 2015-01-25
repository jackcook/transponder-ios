//
//  ContactsViewController.m
//  Transponder
//
//  Created by Jacob Banks on 1/24/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    APAddressBook *addressBook = [[APAddressBook alloc] init];
    addressBook.fieldsMask = APContactFieldFirstName;
    [addressBook loadContacts:^(NSArray *contacts, NSError *error) {
        self.retrievedContacts = contacts;
        
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.retrievedContacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    APContact *contact = self.retrievedContacts[indexPath.row];
    cell.textLabel.text = contact.firstName;
    
    return cell;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
