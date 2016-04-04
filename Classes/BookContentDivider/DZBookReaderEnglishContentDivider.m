//
//  DZBookReaderEnglishContentDivider.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/4.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "DZBookReaderEnglishContentDivider.h"

@interface DZBookReaderEnglishContentDivider()

@property (nonatomic, strong)NSArray *arrayOfWord;

@end

@implementation DZBookReaderEnglishContentDivider

- (instancetype)initWithBookContent:(NSString *)bookContent
{
    self = [super initWithBookContent:bookContent];
    if (self)
    {
        [self makeArrayOfWord];
    }
    return self;
}

- (void)makeArrayOfWord
{
    if (self.bookContent.length == 0) \
    {
        self.arrayOfWord = nil;
        return;
    }
    
    self.arrayOfWord = [self.bookContent componentsSeparatedByString:@" "];
}

- (NSString *)divdeBookContentWithWordRange:(NSRange)range
{
    if (self.arrayOfWord.count == 0)
    {
        return nil;
    }
    
    NSInteger fromIndex = range.location;
    NSInteger indexMax = self.arrayOfWord.count - 1;
    
    if (fromIndex > indexMax)
    {
        return nil;
    }
    
    NSInteger length = MIN(range.length, indexMax - fromIndex + 1);
    NSRange rangeReal = NSMakeRange(fromIndex, length);
    
    NSArray *arrayOfWordToDivide = [self.arrayOfWord subarrayWithRange:rangeReal];
    NSString *divdeResult = [arrayOfWordToDivide componentsJoinedByString:@" "];
    return divdeResult;
}

- (NSInteger)wordCountInBook
{
    return self.arrayOfWord.count;
}

- (NSInteger)wordNumPerPage
{
    return 100;
}

@end
