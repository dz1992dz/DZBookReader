//
//  DZBookRecordList.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/3.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "DZBookRecordList.h"
#import "DZBookRecord.h"

static NSString *const keyMaxIdentifier = @"maxIdentifier";
static NSString *const keyArrayOfBookRecord = @"arrayOfBookRecord";

@implementation DZBookRecordList

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *recordListDic = [NSMutableDictionary dictionary];
    [recordListDic setObject:@(self.maxIdentifier) forKey:keyMaxIdentifier];
    
    NSArray *arrayOfRecordDic = [DZBookRecordList arrayOfRecordDicWithArrayOfRecord:self.arrayOfBookRecord];
    if (arrayOfRecordDic.count > 0)
    {
        [recordListDic setObject:arrayOfRecordDic forKey:keyArrayOfBookRecord];
    }
    
    return recordListDic;
}

+ (instancetype)instanceFromDictionary:(NSDictionary *)dictionary
{
    if (dictionary == nil)
    {
        return [self freshBookRecordList];
    }
    
    DZBookRecordList *recordList = [[DZBookRecordList alloc] init];
    
    recordList.maxIdentifier = [[dictionary objectForKey:keyMaxIdentifier] integerValue];
    
    NSArray *arrayOfRecordDic = [dictionary objectForKey:keyArrayOfBookRecord];
    recordList.arrayOfBookRecord = [self arrayOfRecordWithArrayOfRecordDic:arrayOfRecordDic];
    
    return recordList;
}

+ (NSArray *)arrayOfRecordWithArrayOfRecordDic:(NSArray *)arrayOfRecordDic
{
    NSMutableArray *recordArray = [NSMutableArray array];
    [arrayOfRecordDic enumerateObjectsUsingBlock:^(NSDictionary * recordDic, NSUInteger idx, BOOL * _Nonnull stop)
    {
        [recordArray addObject:[DZBookRecord instanceFromDictionary:recordDic]];
    }];
    
    return recordArray;
}

+ (NSArray *)arrayOfRecordDicWithArrayOfRecord:(NSArray *)arrayOfRecord
{
    NSMutableArray *recordDicArray = [NSMutableArray array];
    [arrayOfRecord enumerateObjectsUsingBlock:^(DZBookRecord *record, NSUInteger idx, BOOL * _Nonnull stop)
     {
         [recordDicArray addObject:[record toDictionary]];
     }];
    
    return recordDicArray;
}

+ (DZBookRecordList *)freshBookRecordList
{
    DZBookRecordList *recordList = [[DZBookRecordList alloc] init];
    recordList.maxIdentifier = -1;
    recordList.arrayOfBookRecord = nil;
    return recordList;
}

@end
