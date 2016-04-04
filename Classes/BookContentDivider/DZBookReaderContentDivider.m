//
//  DZBookReaderContentDivider.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/4.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "DZBookReaderContentDivider.h"
#import "DZBookReaderChineseContentDivider.h"
#import "DZBookReaderEnglishContentDivider.h"

@interface DZBookReaderContentDivider()

@property (nonatomic, strong)NSString *bookContent;

@end

@implementation DZBookReaderContentDivider

+ (instancetype)instanceWithBookContent:(NSString *)bookContent language:(DZBookRecordLanguage)language
{
    DZBookReaderContentDivider *contentDivider = nil;
    
    switch (language)
    {
        case DZBookRecordLanguageChinese:
        {
            contentDivider = [[DZBookReaderChineseContentDivider alloc] initWithBookContent:bookContent];
        }
            break;
        case DZBookRecordLanguageEnglish:
        {
            contentDivider = [[DZBookReaderEnglishContentDivider alloc] initWithBookContent:bookContent];
        }
            break;
            
        default:
        {
            contentDivider = [[DZBookReaderChineseContentDivider alloc] initWithBookContent:bookContent];
        }
            break;
    }
    
    return contentDivider;
}

- (instancetype)initWithBookContent:(NSString *)bookContent
{
    self = [super init];
    if (self)
    {
        self.bookContent = bookContent;
    }
    return self;
}

#pragma mark - Must Overwrite
- (NSString *)divdeBookContentWithWordRange:(NSRange)range
{
    return nil;
}

- (NSString *)wordUnitName
{
    return nil;
}

- (NSInteger)wordCountInBook
{
    return 0;
}

- (NSInteger)wordNumPerPage;
{
    return 0;
}
@end
