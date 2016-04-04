//
//  DZBookReaderPlayerViewController.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/4.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "DZBookReaderPlayerViewController.h"
#import "DZBookReaderContentDivider.h"
#import "NSString+DZBookReader.h"
#import "DZBookSpeaker.h"
#import "DZBookRecordManager.h"

@interface DZBookReaderPlayerViewController ()

@property (nonatomic, strong)DZBookRecord *bookRecord;
@property (nonatomic, strong)DZBookReaderContentDivider *bookContentDivider;

@property (strong, nonatomic) IBOutlet UILabel *labelBookContent;
@property (strong, nonatomic) IBOutlet UISlider *sliderProgress;
@property (strong, nonatomic) IBOutlet UILabel *labelProgress;
@property (strong, nonatomic) IBOutlet UIButton *buttonPlay;

@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) BOOL isStopped;
@property (assign, nonatomic) BOOL isPaused;

@end

@implementation DZBookReaderPlayerViewController

- (void)dealloc
{
    [[DZBookSpeaker shareSpeaker] stopSpeak];
}

+ (instancetype)instanceWithBookRecord:(DZBookRecord *)bookRecord
{
    DZBookReaderPlayerViewController *viewController = [[DZBookReaderPlayerViewController alloc] initWithBookRecord:bookRecord];
    return viewController;
}

- (instancetype)initWithBookRecord:(DZBookRecord *)bookRecord
{
    self = [super initWithNibName:@"DZBookReaderPlayerViewController" bundle:nil];
    if (self)
    {
        self.bookRecord = bookRecord;
        
        NSString *bookContent = [NSString dz_stringBookContentWithBookIdentifier:bookRecord.identifier];
        self.bookContentDivider = [DZBookReaderContentDivider instanceWithBookContent:bookContent language:bookRecord.language];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureViewElements];
    self.navigationItem.title = @"电子书播放器";
    
    NSInteger pageToSpeak = self.bookRecord.readedWordNum / self.bookContentDivider.wordNumPerPage;
    [self startSpeakPage:pageToSpeak];
    
    self.isStopped = NO;
    self.isPaused = NO;
}

- (void)configureViewElements
{
    [self.labelBookContent setAdjustsFontSizeToFitWidth:YES];
    [self.labelBookContent setMinimumScaleFactor:0.5];
    
    [self.sliderProgress setMinimumValue:0];
    [self.sliderProgress setMaximumValue:[self maxPage]];
}


- (void)setIsPaused:(BOOL)isPaused
{
    if (isPaused)
    {
        [self.buttonPlay setTitle:@"继续" forState:UIControlStateNormal];
        [[DZBookSpeaker shareSpeaker] pauseSpeak];
    }
    else
    {
        [self.buttonPlay setTitle:@"暂停" forState:UIControlStateNormal];
        if (self.isStopped)
        {
            [self startSpeakPage:self.currentPage];
        }
        else
        {
            [[DZBookSpeaker shareSpeaker] continueSpeak];
        }
    }
    _isPaused = isPaused;
}


- (void)stopAndJumpToPage:(NSInteger)page
{
    self.isStopped = YES;
    if (self.isPaused)
    {
        [self updateViewWithPage:page];
    }
    else
    {
        [self startSpeakPage:page];
    }
}

- (void)startSpeakPage:(NSInteger)page
{
    if (page <0 || page > [self maxPage])
    {
        return;
    }
    
    self.isStopped = NO;
    [self updateViewWithPage:page];
    [self updateBookRecordWithPage:page];
    NSString *stringToSpeak = [self bookContentAtPage:page];
    __weak typeof(self) weakSelf = self;
    [[DZBookSpeaker shareSpeaker] speakString:stringToSpeak language:self.bookRecord.language completion:^(NSString *speakedString)
     {
         [weakSelf startSpeakPage:page + 1];
     }];
}

- (void)updateViewWithPage:(NSInteger)page
{
    if (page <0 || page > [self maxPage])
    {
        return;
    }
    
    self.currentPage = page;
    [self.sliderProgress setValue:page];
    [self.labelProgress setText:[NSString stringWithFormat:@"%ld/%ld",page + 1,[self maxPage] + 1]];
    
    [self.labelBookContent setText:[self bookContentAtPage:page]];
}

- (void)updateBookRecordWithPage:(NSInteger)page
{
    self.bookRecord.readedWordNum = page * self.bookContentDivider.wordNumPerPage;
    self.bookRecord.progress = page * 1.0 / [self maxPage];
    [[DZBookRecordManager shareManager] updateBookRecord:self.bookRecord];
}

- (NSString *)bookContentAtPage:(NSInteger)page
{
    NSRange rangeBookContent = NSMakeRange(page * [self.bookContentDivider wordNumPerPage], [self.bookContentDivider wordNumPerPage]);
    NSString *bookContent = [self.bookContentDivider divdeBookContentWithWordRange:rangeBookContent];
    return bookContent;
}

- (NSInteger)maxPage
{
    NSInteger wordCount = [self.bookContentDivider wordCountInBook];
    NSInteger maxPage = ceil(wordCount * 1.0 / [self.bookContentDivider wordNumPerPage]) - 1;
    return maxPage;
}

#pragma mark - Action

- (IBAction)progressSliderValueChanged:(UISlider *)slider
{
    [[DZBookSpeaker shareSpeaker] stopSpeak];
    [self updateViewWithPage:slider.value];
}
- (IBAction)progressSliderTouchUpInside:(UISlider *)slider
{
    [self stopAndJumpToPage:slider.value];
}

- (IBAction)onClickButtonLeft:(id)sender
{
    [self stopAndJumpToPage:self.currentPage - 1];
}

- (IBAction)onClickButtonRight:(id)sender
{
    [self stopAndJumpToPage:self.currentPage + 1];
}

- (IBAction)onClickButtonPlay:(id)sender
{
    self.isPaused = !self.isPaused;
}

@end
