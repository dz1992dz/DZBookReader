//
//  DZBookSpeaker.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/4.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "DZBookSpeaker.h"
#import <AVFoundation/AVFoundation.h>

@interface DZBookSpeaker()<AVSpeechSynthesizerDelegate>

@property (nonatomic ,strong)AVSpeechSynthesizer *speechSynthesizer;

@property (nonatomic ,copy)void(^speakCompletionBlock)(NSString *speakedString);

@end

@implementation DZBookSpeaker

+ (instancetype)shareSpeaker
{
    static dispatch_once_t onceToken;
    static DZBookSpeaker *speaker = nil;
    dispatch_once(&onceToken, ^
    {
        speaker = [[DZBookSpeaker alloc] init];
    });
    return speaker;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
        self.speechSynthesizer.delegate = self;
    }
    return self;
}

- (AVSpeechUtterance *)speechUtteranceWithString:(NSString *)string language:(DZBookRecordLanguage)language
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:string];
    
    NSDictionary *mapLanguageToLanguageCode = @{
                                                @(DZBookRecordLanguageChinese):@"zh-CN",
                                                @(DZBookRecordLanguageEnglish):@"en-US"};
    
    NSString *languageCode = [mapLanguageToLanguageCode objectForKey:@(language)];
    
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:languageCode];
    
    utterance.voice = voice;
    
    return utterance;
}

- (void)speakString:(NSString *)string language:(DZBookRecordLanguage)language completion:(void (^)(NSString *))completion
{
    [self stopSpeak];
    self.speakCompletionBlock = completion;
    AVSpeechUtterance *utterance = [self speechUtteranceWithString:string language:language];
    [self.speechSynthesizer speakUtterance:utterance];
}

- (void)stopSpeak
{
    self.speakCompletionBlock = nil;
    [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (void)pauseSpeak
{
    [self.speechSynthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
}

- (void)continueSpeak
{
    [self.speechSynthesizer continueSpeaking];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    if (self.speakCompletionBlock)
    {
        self.speakCompletionBlock(utterance.speechString);
    }
}

@end
