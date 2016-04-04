//
//  DZBookRecordManager.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/3.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "DZBookRecordManager.h"
#import "DZBookRecordList.h"
#import "DZBookReader-var.h"

@interface DZBookRecordManager()

@property (nonatomic, strong)DZBookRecordList *bookRecordList;

@end


@implementation DZBookRecordManager

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static DZBookRecordManager *manager = nil;
    dispatch_once(&onceToken, ^
    {
        manager = [[DZBookRecordManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        [self loadDataFromLocal];
    }
    return self;
}

- (void)registBookRecordWithBookRecordToRegist:(DZBookRecord *)bookRecordToRegist bookContent:(NSString *)bookContent
{
    NSInteger bookIdentify = self.bookRecordList.maxIdentifier + 1;
    
    NSError *error = nil;
    [bookContent writeToFile:[self filePathWithBookIdentify:bookIdentify] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error == nil)
    {
        self.bookRecordList.maxIdentifier = bookIdentify;
        DZBookRecord *bookRecord = [DZBookRecord instanceWithBookName:bookRecordToRegist.bookName identifier:bookIdentify language:bookRecordToRegist.language];
        
        NSMutableArray *arrayOfRecord = [NSMutableArray arrayWithArray:self.bookRecordList.arrayOfBookRecord];
        [arrayOfRecord addObject:bookRecord];
        self.bookRecordList.arrayOfBookRecord = arrayOfRecord;
    }
}


- (NSArray *)arrayOfBookRecord
{
    return self.bookRecordList.arrayOfBookRecord;
}

- (void)updateBookRecord:(DZBookRecord *)bookRecord
{
    __block NSInteger indexBookRecord = NSNotFound;
    [self.bookRecordList.arrayOfBookRecord enumerateObjectsUsingBlock:^(DZBookRecord *bookRecordOld, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if (bookRecordOld.identifier == bookRecord.identifier)
        {
            indexBookRecord = idx;
            *stop = YES;
        }
    }];
    
    if (indexBookRecord == NSNotFound)
    {
        return;
    }
    
    NSMutableArray *arrayOfBookRecord = [NSMutableArray arrayWithArray:self.bookRecordList.arrayOfBookRecord];
    [arrayOfBookRecord replaceObjectAtIndex:indexBookRecord withObject:bookRecord];
    
    self.bookRecordList.arrayOfBookRecord = arrayOfBookRecord;
    
    [self synchronousDataToLocal];
}

#pragma mark - handle notification

- (void)handleDidEnterBackgroundNotification
{
    [self synchronousDataToLocal];
}

#pragma mark - local storage

- (NSString *)filePathOfBookRecordList
{
    NSString *path = [self filePathWithAppendingPath:@"bookRecordList.plist"];
    return path;
}

- (NSString *)filePathWithBookIdentify:(NSInteger)bookIdentify
{
    NSString *appendingPath = [NSString stringWithFormat:bookFileNameFormat,bookIdentify];
    
    NSString *filePath = [self filePathWithAppendingPath:appendingPath];
    
    return filePath;
}

- (NSString *)filePathWithAppendingPath:(NSString *)appendingPath
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:appendingPath];
    return filePath;
}

- (void)loadDataFromLocal
{
    NSDictionary *dicBookRecordList = [NSDictionary dictionaryWithContentsOfFile:[self filePathOfBookRecordList]];
    self.bookRecordList = [DZBookRecordList instanceFromDictionary:dicBookRecordList];
}

- (void)synchronousDataToLocal
{
    NSDictionary *dicBookRecordList = [self.bookRecordList toDictionary];
    [dicBookRecordList writeToFile:[self filePathOfBookRecordList] atomically:YES];
}


@end
