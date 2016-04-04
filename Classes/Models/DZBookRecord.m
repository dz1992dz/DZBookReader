//
//  DZBookRecord.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/3.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "DZBookRecord.h"

static NSString *const keyBookName = @"bookName";
static NSString *const keyIdentifier = @"identifier";
static NSString *const keyReadedWordNum = @"readedWordNum";
static NSString *const keyLanguage = @"language";
static NSString *const keyProgress = @"progress";

@implementation DZBookRecord

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionary];
    
    if (self.bookName)
    {
        [recordDic setObject:self.bookName forKey:keyBookName];
    }
    [recordDic setObject:@(self.identifier) forKey:keyIdentifier];
    [recordDic setObject:@(self.readedWordNum) forKey:keyReadedWordNum];
    [recordDic setObject:@(self.language) forKey:keyLanguage];
    [recordDic setObject:@(self.progress) forKey:keyProgress];
    return recordDic;
}


+ (instancetype)instanceFromDictionary:(NSDictionary *)dictionary
{
    NSString *bookName = [dictionary objectForKey:keyBookName];
    NSInteger identifier = [[dictionary objectForKey:keyIdentifier] integerValue];
    NSInteger readedWordNum = [[dictionary objectForKey:keyReadedWordNum] integerValue];
    DZBookRecordLanguage language = [[dictionary objectForKey:keyLanguage] integerValue];
    float progress = [[dictionary objectForKey:keyProgress] floatValue];
    
    DZBookRecord *bookRecord = [[DZBookRecord alloc] initWithBookName:bookName identifier:identifier readedWordNum:readedWordNum language:language progress:progress];
    
    return bookRecord;
}

+ (instancetype)instanceWithBookName:(NSString *)bookName identifier:(NSInteger)identifier language:(DZBookRecordLanguage)language
{
    DZBookRecord *bookRecord = [[DZBookRecord alloc] initWithBookName:bookName identifier:identifier readedWordNum:0 language:language progress:0];
    return bookRecord;
}


- (instancetype)initWithBookName:(NSString *)bookName identifier:(NSInteger)identifier readedWordNum:(NSInteger)readedWordNum language:(DZBookRecordLanguage)language progress:(float)progress
{
    self = [super init];
    if (self)
    {
        self.bookName = bookName;
        self.identifier = identifier;
        self.readedWordNum = readedWordNum;
        self.language = language;
        self.progress = progress;
    }
    return self;
}

- (void)setProgress:(float)progress
{
    _progress = MAX(0, progress);
    _progress = MIN(1, _progress);
}


@end
