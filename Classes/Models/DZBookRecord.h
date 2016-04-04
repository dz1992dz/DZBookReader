//
//  DZBookRecord.h
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/3.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZBookReader-var.h"

@interface DZBookRecord : NSObject

@property (nonatomic, strong)NSString *bookName;
@property (nonatomic, assign)NSInteger identifier;
@property (nonatomic, assign)NSInteger readedWordNum;
@property (nonatomic, assign)DZBookRecordLanguage language;
@property (nonatomic, assign)float progress;

- (NSDictionary *)toDictionary;
+ (instancetype)instanceFromDictionary:(NSDictionary *)dictionary;
+ (instancetype)instanceWithBookName:(NSString *)bookName identifier:(NSInteger)identifier language:(DZBookRecordLanguage)language;

@end
