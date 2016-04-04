//
//  DZBookRecordList.h
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/3.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZBookRecordList : NSObject

@property (nonatomic, strong)NSArray *arrayOfBookRecord;

@property (nonatomic, assign)NSInteger maxIdentifier;

- (NSDictionary *)toDictionary;
+ (instancetype)instanceFromDictionary:(NSDictionary *)dictionary;



@end
