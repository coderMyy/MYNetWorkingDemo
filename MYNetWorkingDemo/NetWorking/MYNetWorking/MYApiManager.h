//
//  MYApiManager.h
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYApiResponseObject.h"
#import "MYApiRequestObject.h"

@protocol MYApiRequestDelegate<NSObject>
@required
//请求完成回调
- (void)requestFinished:(MYApiRequestObject *)request response:(MYApiResponseObject *)response;

@optional
//网络实时监听
- (void)networkRealtimeCheck:(ReachabilityStatus)status;
//请求进度监听
- (void)requestProgress:(MYApiRequestObject *)request progress:(CGFloat)progress;

@end

@interface MYApiManager : NSObject

@property (nonatomic, weak) id<MYApiRequestDelegate> delegate;
//代理方法方法调用
- (void)excuteRequest:(MYApiRequestObject *)request;

//block方式调用
- (void)excuteRequest:(MYApiRequestObject *)request finished:(MYApiRequestFinishedCallback)finishCallback progress:(MYApiRequestProgressCallback)progress;

//取消请求
- (void)excuteCancelRequest:(NSString *)tag;

@end
