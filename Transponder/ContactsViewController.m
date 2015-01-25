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
    // Do any additional setup after loading the view.
    tableview.delegate = self;
    tableview.dataSource = self;
    
    RetrievedNamesMutableArray = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [RetrievedNamesMutableArray removeAllObjects];
    
    ABAddressBookRef UsersAddressBook = ABAddressBookCreate();
    
    //contains details for all the contacts
    CFArrayRef ContactInfoArray = ABAddressBookCopyArrayOfAllPeople(UsersAddressBook);
    
    //get the total number of count of the users contact
    CFIndex numberofPeople = CFArrayGetCount(ContactInfoArray);
    
    //iterate through each record and add the value in the array
    for (int i =0; i<numberofPeople; i++) {
        ABRecordRef ref = CFArrayGetValueAtIndex(ContactInfoArray, i);
        ABMultiValueRef names = (__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(ref, kABPersonFirstNameProperty));
        NSLog(@"name = %@",names);
        [RetrievedNamesMutableArray addObject:(__bridge id)(names)];
        
    }
    //finally reload the table to see the first name in the table view
    [tableview reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [RetrievedNamesMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier];
        
    // Configure the cell...
    
    if ([RetrievedNamesMutableArray count]>0) {
        cell.textLabel.text = [RetrievedNamesMutableArray objectAtIndex:indexPath.row];
        
    }
    
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
