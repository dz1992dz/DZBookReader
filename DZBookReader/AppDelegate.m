//
//  AppDelegate.m
//  DZBookReader
//
//  Created by Dongzhuang on 16/4/3.
//  Copyright © 2016年 DZ. All rights reserved.
//

#import "AppDelegate.h"
#import "DZBookRecordManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{ 
    [self registBooksFromDemoBundleIfNeeded];
    
    return YES;
}


- (void)registBooksFromDemoBundleIfNeeded
{
    NSString *keyAlreadyRegistBundleBooks = @"keyAlreadyRegistBundleBooks";
    BOOL alreadyRegist = [[NSUserDefaults standardUserDefaults] boolForKey:keyAlreadyRegistBundleBooks];
    if (alreadyRegist)
    {
        return;
    }
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DemoBooks" ofType:@"plist" ];
    NSArray *arrayOfBundleBookRecord = [NSArray arrayWithContentsOfFile:filePath];
    
    [arrayOfBundleBookRecord enumerateObjectsUsingBlock:^(NSDictionary *dicBundleBook, NSUInteger idx, BOOL * _Nonnull stop)
    {
        NSString *bookName = [dicBundleBook valueForKey:@"bookName"];
        NSString *fileName = [dicBundleBook valueForKey:@"fileName"];
        NSInteger language = [[dicBundleBook valueForKey:@"language"] integerValue];
        
        NSString *bookContentFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
        NSError *error = nil;
        NSString *bookContent = [NSString stringWithContentsOfFile:bookContentFilePath encoding:NSUTF8StringEncoding error:&error];
        if (error == nil)
        {
            DZBookRecord *bookRecordToRegist = [[DZBookRecord alloc] init];
            bookRecordToRegist.bookName = bookName;
            bookRecordToRegist.language = language;
            
            [[DZBookRecordManager shareManager] registBookRecordWithBookRecordToRegist:bookRecordToRegist bookContent:bookContent];
        }
    }];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:keyAlreadyRegistBundleBooks];
    
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
