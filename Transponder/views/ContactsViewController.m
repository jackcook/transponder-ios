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
    addressBook.fieldsMask = APContactFieldFirstName | APContactFieldLastName | APContactFieldPhones;
    [addressBook loadContacts:^(NSArray *contacts, NSError *error) {
        NSMutableArray *contactsToSave = [contacts mutableCopy];
        for (int i = 0; i < contactsToSave.count; i++) {
            APContact *contact = [contactsToSave objectAtIndex:i];
            if (contact.phones.count == 0) {
                [contactsToSave removeObject:contact];
            }
        }
        
        self.retrievedContacts = contactsToSave;
        
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    
    APContact *contact = self.retrievedContacts[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    cell.detailTextLabel.text = contact.phones[0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneButtonPressed:(id)sender {
    [Common sharedInstance].setupEmergencyContacts = self.retrievedContacts;
    [self performSegueWithIdentifier:@"doneSegue" sender:self];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
