//
//  ViewController.m
//  UISearchControllerExample
//
//  Created by SuHan Kim on 09/02/2018.
//  Copyright © 2018 edcan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate>

@property(retain, nonatomic) UISearchController *searchController;
@property(strong, nonatomic) NSArray *searchedArray;
@property(strong, nonatomic) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [[NSArray alloc] initWithObjects:@"Hello", @"World", @"Desu", @"Kedo", @"Mina", @"JJang", nil];
    self.searchedArray = [[NSArray alloc] init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.delegate = (UIViewController<UISearchBarDelegate> *) self;
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"self CONTAINS[c] %@", searchString];
    self.searchedArray = [self.array filteredArrayUsingPredicate: predicate];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active){
        return [self.searchedArray count];
    }else{
        return [self.array count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Sample"];
    UILabel *label = (UILabel *) [cell.contentView.subviews objectAtIndex: 0];
    
    if(self.searchController.active){
        [label setText: [self.searchedArray objectAtIndex: indexPath.row]];
    }else{
        [label setText: [self.array objectAtIndex: indexPath.row]];
    }
    
    return cell;
}

@end
