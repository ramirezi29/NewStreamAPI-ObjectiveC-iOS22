//
//  RAMHeadlinesTableViewController.m
//  NewStream
//
//  Created by Ivan Ramirez on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import "RAMHeadlinesTableViewController.h"
#import "RAMNewsAPIClient.h"

// NOTE: - Import the entire swift file
//project name - Swift is what were going to call it 
#import "NewStream-Swift.h"

@interface RAMHeadlinesTableViewController ()

@property(nonatomic, readwrite) NSArray<RAMNews *> *articles;

@end

@implementation RAMHeadlinesTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // MARK: - call fetch
    [RAMNewsAPIClient fetchTopHeadlinesWithBlock:^(NSArray<RAMNews *> * _Nullable articles) {
        self.articles = articles;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.articles = articles;
            [[self tableView] reloadData];
        });
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // NOTE: - Needs to be self. not
    return [self.articles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RAMHeadlineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headlineCell" forIndexPath:indexPath];
    RAMNews *news = self.articles[indexPath.row];
    
    cell.news = news;
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] == @"toDetailVC" ]){
        RAMNewsDetailViewController *destinationVC = [segue destinationViewController];
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        RAMNews *news = self.articles[indexPath.row];
        RAMHeadlineTableViewCell *selectedCell = UIImage *photo = [self.tableView cellForRowAtIndexPath:indexPath];
        UIImage *photo = [[selectedCell newsImageView] image];
        destinationVC
        destinationVC.news = news
    }
}


@end
