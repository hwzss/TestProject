//
//  ViewController.m
//  ShowErrorDemo
//
//  Created by qwkj on 2018/2/18.
//  Copyright © 2018年 qwkj. All rights reserved.
//

#import "ViewController.h"
#import <SSZipArchive/SSZipArchive.h>
#import "FileDownloaderManger.h"

static NSString *createUnzipPath() {
    NSString *systemCacheDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSString *themeCacheDir = [systemCacheDir stringByAppendingPathComponent:@"Caches/wz_theme_cahches"];
    NSString *destinationPath = [themeCacheDir stringByAppendingPathComponent:@"mainTheme"];
    return destinationPath;
}

static void unzipFile(NSString *path, NSString *destinationPath) {
    int const TEST_NUM = 16;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < TEST_NUM; i++) {
            NSError *error;
            [SSZipArchive unzipFileAtPath:path toDestination:destinationPath overwrite:YES password:nil error:&error];
            if (!error) {
                NSLog(@"successed in global_queue");
            }
            else {
                NSLog(@"failed in global_queue,%@", [error description]);
            }
        }
    });
    for (int i = 0; i < TEST_NUM; i++) {
        NSError *error;
        [SSZipArchive unzipFileAtPath:path toDestination:destinationPath overwrite:YES password:nil error:&error];
        if (!error) {
            NSLog(@"successed in main queue");
        }
        else {
            NSLog(@"failed in main queue,%@", [error description]);
        }
    }
}

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [FileDownloaderManger downloadThemePachForm:@"https://github.com/hwzss/WZTheme/raw/master/theme.zip"
                              completionHandler:^(NSURL *location, NSError *error) {
                                  if (!error) {
                                      unzipFile(location.path, createUnzipPath());
                                  }
                                  
                              }];
}

@end
