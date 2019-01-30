//
//  MYApiManager.m
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import "MYApiManager.h"
#import "MYApiRequestObject.h"


@interface MYApiManager ()

@property (nonatomic, strong) NSMutableDictionary *requestObjs;

@end

@implementation MYApiManager

- (void)excuteRequest:(MYApiRequestObject *)request
{
    [self start:request finished:nil progress:nil];
}


- (void)excuteRequest:(MYApiRequestObject *)request finished:(MYApiRequestFinishedCallback)finishCallback progress:(MYApiRequestProgressCallback)progress
{
    [self start:request finished:finishCallback progress:progress];
}

- (void)start:(MYApiRequestObject *)request finished:(MYApiRequestFinishedCallback)finishCallback progress:(MYApiRequestProgressCallback)progressBack
{
#ifdef DEBUG
    if (!request.urlString.length) {
//        HudShowMessage(@"缺少url",[UIApplication sharedApplication].keyWindow, 2);
        NSLog(@"缺少url");
        return;
    }
#endif
    
    MYApiRequestObject *obj = [self.requestObjs objectForKey:request.requestTag];
    if (obj){
        [obj cancelRequest];
    };
    obj = request;
    
    [self.requestObjs setObject:obj forKey:obj.requestTag];
    
    //判断网络
    ReachabilityStatus networkStatus = [GLobalRealReachability currentReachabilityStatus];
    if (networkStatus == RealStatusNotReachable) { //断网
        MYApiResponseObject *failedResponse = [MYApiResponseObject new];
        failedResponse.successed = NO;
        failedResponse.tipMsg = @"网络错误";
        failedResponse.networkStatus = networkStatus;
        if ([self.delegate respondsToSelector:@selector(requestFinished:response:)]) {
            [self.delegate requestFinished:request response:failedResponse];
        }
        if (finishCallback) {
            finishCallback(request,failedResponse);
        }
        return;
    }
    
    [obj sendRequest:^(MYApiRequestObject *request, MYApiResponseObject *response) {
        if ([self.delegate respondsToSelector:@selector(requestFinished:response:)]) {
            [self.delegate requestFinished:request response:response];
        }
        if (finishCallback) {
            finishCallback(request,response);
        }
    } progress:^(MYApiRequestObject *request, CGFloat progress) {
        if ([self.delegate respondsToSelector:@selector(requestProgress:progress:)]) {
            [self.delegate requestProgress:request progress:progress];
        }
        if (progressBack) {
            progressBack(request,progress);
        }
    }];
}


- (void)excuteCancelRequest:(NSString *)tag
{
    MYApiRequestObject *obj = [self.requestObjs objectForKey:tag];
    if (!obj) return;
    [obj cancelRequest];
}

- (void)networkChanged:(NSNotification *)noti
{
    if ([self.delegate respondsToSelector:@selector(networkRealtimeCheck:)]) {
        RealReachability *reachability = (RealReachability *)noti.object;
        ReachabilityStatus status = [reachability currentReachabilityStatus];
        [self.delegate networkRealtimeCheck:status];
    }
}

- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:kRealReachabilityChangedNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (NSMutableDictionary *)requestObjs
{
    if (!_requestObjs) {
        _requestObjs = [NSMutableDictionary dictionary];
    }
    return _requestObjs;
}

@end
