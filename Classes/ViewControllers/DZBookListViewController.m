//
//  DZBookListViewController.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/3.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "DZBookListViewController.h"
#import "DZBookRecordManager.h"
#import "DZBookReaderPlayerViewController.h"

@interface DZBookListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation DZBookListViewController

+ (instancetype)instance
{
    DZBookListViewController *controller = [[DZBookListViewController alloc] initWithNibName:@"DZBookListViewController" bundle:nil];
    return controller;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"电子书列表"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = [DZBookRecordManager shareManager].arrayOfBookRecord.count;
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DZBookRecord *bookRecord = [DZBookRecordManager shareManager].arrayOfBookRecord[indexPath.row];
    
    NSString *cellIdentifier = @"bookListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = bookRecord.bookName;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"进度：%d%%",(int)(bookRecord.progress * 100)];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DZBookRecord *bookRecord = [DZBookRecordManager shareManager].arrayOfBookRecord[indexPath.row];
    DZBookReaderPlayerViewController *playerController = [DZBookReaderPlayerViewController instanceWithBookRecord:bookRecord];
    [self.navigationController pushViewController:playerController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
