//
//  MYNetWorkingTool.h
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYApiResponseObject.h"

typedef void(^MYNetWorkingFinishedCallback)(MYApiResponseObject *response);
typedef void(^MYNetWorkingProgressCallback)(CGFloat progress);
@class MYApiRequestObject,MYApiResponseObject;
@interface MYNetWorkingTool : NSObject

+ (NSURLSessionDataTask *)excuteGetRequest:(MYApiRequestObject *)request progress:(MYNetWorkingProgressCallback)progress
                                  finished:(MYNetWorkingFinishedCallback)finished;

+ (NSURLSessionDataTask *)excutePostRequest:(MYApiRequestObject *)request progress:(MYNetWorkingProgressCallback)progress
                                   finished:(MYNetWorkingFinishedCallback)finished;

@end
