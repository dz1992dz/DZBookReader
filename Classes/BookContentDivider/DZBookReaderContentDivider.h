//
//  DZBookReaderContentDivider.h
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/4.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZBookReader-var.h"

@interface DZBookReaderContentDivider : NSObject

+ (instancetype)instanceWithBookContent:(NSString *)bookContent language:(DZBookRecordLanguage)language;

- (NSString *)divdeBookContentWithWordRange:(NSRange)range;

- (NSInteger)wordCountInBook;

- (NSInteger)wordNumPerPage;

//protect
@property (nonatomic, strong, readonly)NSString *bookContent;
- (instancetype)initWithBookContent:(NSString *)bookContent;

@end
