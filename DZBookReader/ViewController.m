//
//  ViewController.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/3.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "ViewController.h"

#import "DZBookListViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)onClickBookListButton:(id)sender
{
    [self.navigationController pushViewController:[DZBookListViewController instance] animated:YES];
}


@end
