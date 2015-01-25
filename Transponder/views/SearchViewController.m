//
//  SearchViewController.m
//  Transponder
//
//  Created by Jack Cook on 1/25/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSURL *url = [NSURL URLWithString:@"https://api.foursquare.com/v2/venues/search"];
    NSDictionary *URLParams = @{
        @"client_id": @"MCVSYBTHAIBJDRRMDA4X13AIHUM3AAHHPOTCZWAOAKILTQ0C",
        @"client_secret": @"DBYYBOOYU0MCGPRFVK4UATJVXOEFZ2G4FRQ1WQZDPHJYRAOT",
        @"v": @"20130815",
        @"query": searchText,
        @"ll": [NSString stringWithFormat:@"%f,%f", self.latitude, self.longitude
                ],
    };
    url = NSURLByAppendingQueryParameters(url, URLParams);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.venues = json[@"response"][@"venues"];
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = [self.venues objectAtIndex:indexPath.row][@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [Common sharedInstance].venue = self.venues[indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

static NSString *NSStringFromQueryParameters(NSDictionary* queryParameters) {
    NSMutableArray *parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@", [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding], [value stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}

static NSURL *NSURLByAppendingQueryParameters(NSURL* URL, NSDictionary* queryParameters) {
    NSString *URLString = [NSString stringWithFormat:@"%@?%@", [URL absoluteString], NSStringFromQueryParameters(queryParameters)];
    return [NSURL URLWithString:URLString];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
