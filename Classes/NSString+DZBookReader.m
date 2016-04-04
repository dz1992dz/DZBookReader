//
//  NSString+DZBookReader.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/4.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "NSString+DZBookReader.h"
#import "DZBookReader-var.h"

@implementation NSString(DZBookReader)

+ (instancetype)dz_stringBookContentWithBookIdentifier:(NSInteger)bookIdentifier
{
    NSString *bookFilePath = [self dz_filePathWithBookIdentifier:bookIdentifier];
    
    NSError *error = nil;
    NSString *bookContent = [NSString stringWithContentsOfFile:bookFilePath encoding:NSUTF8StringEncoding error:&error];
    if (error)
    {
        return @"";
    }
    
    return bookContent;
}

+ (NSString *)dz_filePathWithBookIdentifier:(NSInteger)bookIdentifier
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *bookFileName = [NSString stringWithFormat:bookFileNameFormat,bookIdentifier];
    NSString *filePath = [rootPath stringByAppendingPathComponent:bookFileName];
    return filePath;
}

@end
