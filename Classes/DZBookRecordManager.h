//
//  DZBookRecordManager.h
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/3.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZBookRecord.h"

@interface DZBookRecordManager : NSObject

+ (instancetype)shareManager;

- (NSArray *)arrayOfBookRecord;

- (void)registBookRecordWithBookRecordToRegist:(DZBookRecord *)bookRecordToRegist bookContent:(NSString *)bookContent;

- (void)updateBookRecord:(DZBookRecord *)bookRecord;


@end
