//
//  FileDownloaderManger.h
//  ShowErrorDemo
//
//  Created by qwkj on 2018/2/18.
//  Copyright © 2018年 qwkj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WZFileDownloaderCompleteBlock)(NSURL * location, NSError *error);

@interface FileDownloaderManger : NSObject

+ (void)downloadThemePachForm:(NSString *)downlaodLink completionHandler:(WZFileDownloaderCompleteBlock)completionHandler;

@end
