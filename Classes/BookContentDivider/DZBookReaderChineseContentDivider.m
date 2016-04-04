//
//  DZBookReaderChineseContentDivider.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/4.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "DZBookReaderChineseContentDivider.h"

@implementation DZBookReaderChineseContentDivider

- (NSString *)divdeBookContentWithWordRange:(NSRange)range
{
    if (self.bookContent.length == 0)
    {
        return nil;
    }
    
    NSInteger fromIndex = range.location;
    NSInteger indexMax = self.bookContent.length - 1;
    
    if (fromIndex > indexMax)
    {
        return nil;
    }
    
    NSInteger length = MIN(range.length, indexMax - fromIndex +1);
    NSRange rangeReal = NSMakeRange(fromIndex, length);
    
    NSString *divdeResult = [self.bookContent substringWithRange:rangeReal];
    return divdeResult;
}

- (NSInteger)wordCountInBook
{
    return self.bookContent.length;
}

- (NSInteger)wordNumPerPage
{
    return 300;
}

@end
