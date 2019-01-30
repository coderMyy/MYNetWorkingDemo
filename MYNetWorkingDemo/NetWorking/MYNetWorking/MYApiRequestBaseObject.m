//
//  MYApiRequestBaseObject.m
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import "MYApiRequestBaseObject.h"

@interface MYApiRequestBaseObject ()

@property (nonatomic, assign) NSInteger timeout;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *token;//请求的基本参数,可自行更改
@property (nonatomic, copy) NSString *machine_type;//请求的基本参数,可自行更改
@property (nonatomic, assign) MY_APIREQUEST_TYPE requestType;
@property (nonatomic, copy) NSString *requestTag;

@end

@implementation MYApiRequestBaseObject

+ (instancetype)creatRequest:(MY_APIREQUEST_TYPE)requestType urlString:(NSString *)urlString timeout:(NSInteger)timeout requestTag:(NSString *)tag
{
    return [[self alloc]initWithRequest:requestType urlString:urlString timeout:timeout requestTag:tag];
}

- (instancetype)initWithRequest:(MY_APIREQUEST_TYPE)requestType urlString:(NSString *)urlString timeout:(NSInteger)timeout requestTag:(NSString *)tag
{
    //requestTag可以不设定，每次均为不同的请求,此时requestTag为当前时间戳
    if (!tag.length) {
        tag = MYGetCurrentTime();
    }
    MYApiRequestBaseObject *request = [self init];
    request.urlString = urlString;
    request.requestType = requestType;
    request.timeout = timeout;
    request.requestTag = tag;
    return request;
}



+ (NSArray *)modelPropertyBlacklist {
    return @[@"urlString", @"requestType",@"baseUrl",@"timeout",@"task",@"requestTag",@"localCache"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"baseUrl ************* %@\n请求方式 ************* %ld\n完整url ************* %@\n设置超时时间 ************* %ld\n请求参数 ************* %@",self.baseUrl,(long)self.requestType,self.task.originalRequest.URL.absoluteString,(long)self.timeout,self.yy_modelToJSONObject];
}

- (NSInteger)timeout
{
    if (!_timeout) {
        return 30;
    }
    return _timeout;
}

- (MY_APIREQUEST_TYPE)requestType
{
    if (!_requestType) {
        _requestType = MYApiRequestGetType;
    }
    return _requestType;
}

- (NSString *)baseUrl
{
    if (!_baseUrl.length) {
        _baseUrl = baseUrl;
    }
    return _baseUrl;
}

- (NSString *)urlString
{
    return _urlString;
}

//获取当前时间戳
NS_INLINE NSString *MYGetCurrentTime() {
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%llu",recordTime];
}

@end
