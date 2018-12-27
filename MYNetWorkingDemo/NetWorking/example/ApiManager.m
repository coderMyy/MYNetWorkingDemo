//
//  ApiManager.m
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import "ApiManager.h"
#import "RequestObject.h"
#import "MYApiManager.h"

@interface ApiManager ()

@property (nonatomic, strong) MYApiManager *apiManager;

@end

@implementation ApiManager

- (void)excuteGetList:(MYApiExampleFinished)finish
{
    RequestObject *request = [RequestObject creatRequest:MYApiRequestGetType urlString:@"user/user/activity" timeout:10 requestTag:@"list"];
    [self.apiManager excuteRequest:request finished:^(MYApiRequestObject *request, MYApiResponseObject *response) {
        
        //可能我在这里做一些转模型，或者数据的处理，将数据转换成直接可用的。或者一些异常处理
        
        //成功处理
        if (response.successed) {
            finish(request,response.data);
            
        //失败处理
        }else{
            
        }
        
    } progress:nil];
}



- (void)cancelRequest:(NSString *)tag
{
    [self.apiManager excuteCancelRequest:tag];
}


- (MYApiManager *)apiManager
{
    if (!_apiManager) {
        _apiManager = [MYApiManager new];
    }
    return _apiManager;
}

@end
