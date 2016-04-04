//
//  DZBookReaderContentDividerTests.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/4.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DZBookReaderContentDivider.h"

@interface DZBookReaderContentDividerTests : XCTestCase

@end

@implementation DZBookReaderContentDividerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNormalChineseContentDivider
{
    NSString *stringInput = @"0123456789";
    DZBookReaderContentDivider *contentDivider = [DZBookReaderContentDivider instanceWithBookContent:stringInput language:DZBookRecordLanguageChinese];
    {
        NSString *stringDivided = [contentDivider divdeBookContentWithWordRange:NSMakeRange(5, 4)];
        XCTAssertEqualObjects(stringDivided, @"5678");
    }

    {
        NSString *stringDivided = [contentDivider divdeBookContentWithWordRange:NSMakeRange(5, 6)];
        XCTAssertEqualObjects(stringDivided, @"56789");
    }
    
    {
        NSString *stringDivided = [contentDivider divdeBookContentWithWordRange:NSMakeRange(10, 1)];
        XCTAssertNil(stringDivided);
    }
    {
        NSString *stringDivided = [contentDivider divdeBookContentWithWordRange:NSMakeRange(0, 0)];
        XCTAssertEqualObjects(stringDivided, @"");
    }
}

- (void)testInputNotValidChineseContentDivider
{
    DZBookReaderContentDivider *contentDivider = [DZBookReaderContentDivider instanceWithBookContent:nil language:DZBookRecordLanguageChinese];
    NSString *stringDivided = [contentDivider divdeBookContentWithWordRange:NSMakeRange(0, 1)];
    XCTAssertNil(stringDivided);
}

- (void)testNormalEnglishContentDivider
{
    NSString *stringInput = @"I need a job";
    DZBookReaderContentDivider *contentDivider = [DZBookReaderContentDivider instanceWithBookContent:stringInput language:DZBookRecordLanguageEnglish];
    {
        NSString *stringDivided = [contentDivider divdeBookContentWithWordRange:NSMakeRange(0, 2)];
        XCTAssertEqualObjects(stringDivided, @"I need");
    }
    
    {
        NSString *stringDivided = [contentDivider divdeBookContentWithWordRange:NSMakeRange(0, 5)];
        XCTAssertEqualObjects(stringDivided, @"I need a job");
    }
    
    {
        NSString *stringDivided = [contentDivider divdeBookContentWithWordRange:NSMakeRange(4, 1)];
        XCTAssertNil(stringDivided);
    }
    
    {
        NSString *stringDivided = [contentDivider divdeBookContentWithWordRange:NSMakeRange(0, 0)];
        XCTAssertEqualObjects(stringDivided, @"");
    }
    
}

- (void)testInputNotValidEnglishContentDivider
{
    DZBookReaderContentDivider *contentDivider = [DZBookReaderContentDivider instanceWithBookContent:nil language:DZBookRecordLanguageEnglish];
    NSString *stringDivided = [contentDivider divdeBookContentWithWordRange:NSMakeRange(0, 0)];
    XCTAssertNil(stringDivided);
}



@end
