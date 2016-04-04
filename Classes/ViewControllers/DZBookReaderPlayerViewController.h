//
//  DZBookReaderPlayerViewController.h
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/4.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZBookRecord.h"

@interface DZBookReaderPlayerViewController : UIViewController

+ (instancetype)instanceWithBookRecord:(DZBookRecord *)bookRecord;

@end
