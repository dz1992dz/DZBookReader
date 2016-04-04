//
//  DZBookReader-var.h
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/4.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *bookFileNameFormat = @"book_%ld.txt";

typedef NS_OPTIONS(NSInteger, DZBookRecordLanguage)
{
    DZBookRecordLanguageChinese = 0,
    DZBookRecordLanguageEnglish = 1,
};
