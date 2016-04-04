//
//  DZBookSpeaker.h
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/4.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZBookReader-var.h"

@interface DZBookSpeaker : NSObject

+ (instancetype)shareSpeaker;

- (void)speakString:(NSString *)string language:(DZBookRecordLanguage)language completion:(void(^)(NSString *speakedString))completion;

- (void)stopSpeak;
- (void)pauseSpeak;
- (void)continueSpeak;


@end
