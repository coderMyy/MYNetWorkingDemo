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
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *machine_type;
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
#ifdef DEBUG
    if (!tag.length) {
//        HudShowMessage(@"tag必须设定",[UIApplication sharedApplication].keyWindow, 2);
        return nil;
    }
#endif
    MYApiRequestBaseObject *request = [self init];
    request.urlString = urlString;
    request.requestType = requestType;
    request.timeout = timeout;
    request.requestTag = tag;
    return request;
}

- (instancetype)init
{
    if (self = [super init]) {
        
//        if (User_is_login) {
//            _token = [User sharedUser].userInfo.token;
//        }
        _machine_type = @"ios";
    }
    return self;
}


+ (NSArray *)modelPropertyBlacklist {
    return @[@"urlString", @"requestType",@"baseUrl",@"timeout"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"baseUrl ************* %@\n请求方式 ************* %ld\n完整url ************* %@\n设置超时时间 ************* %ld",self.baseUrl,(long)self.requestType,self.task.originalRequest.URL.absoluteString,(long)self.timeout];
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

@end
