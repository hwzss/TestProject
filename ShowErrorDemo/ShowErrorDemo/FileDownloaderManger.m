//
//  FileDownloaderManger.m
//  ShowErrorDemo
//
//  Created by qwkj on 2018/2/18.
//  Copyright © 2018年 qwkj. All rights reserved.
//

#import "FileDownloaderManger.h"

@implementation FileDownloaderManger

+ (void)downloadThemePachForm:(NSString *)downlaodLink completionHandler:(WZFileDownloaderCompleteBlock)completionHandler {
    NSURL *url = [NSURL URLWithString:downlaodLink];
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url
                                                        completionHandler:^(NSURL *_Nullable location, NSURLResponse *_Nullable response, NSError *_Nullable error) {
                                                            !completionHandler ?: completionHandler(location, error);
                                                        }];
    [downloadTask resume];
}

@end
