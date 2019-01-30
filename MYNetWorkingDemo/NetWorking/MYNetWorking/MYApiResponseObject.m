//
//  MYApiResponseObject.m
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import "MYApiResponseObject.h"

@implementation MYApiResponseObject

+ (instancetype)creatResponse:(id)responsObj error:(NSError *)error task:(NSURLSessionDataTask *)task
{
    ReachabilityStatus networkStatus = [GLobalRealReachability currentReachabilityStatus];
    MYApiResponseObject *response = nil;
    if (responsObj) {
        response = [self yy_modelWithJSON:responsObj];
    }else{
        response = [self new];
    }
    NSInteger httpCode = [[task.response valueForKey:@"statusCode"] integerValue];
    response.httpCode = httpCode;
    if (httpCode != 200) { //取消请求
        if (error.code == -999) {
            response.tipMsg = @"";
        }else{
            response.tipMsg = @"网络错误";
        }
        response.errorDesc = error.localizedDescription;
    }else{
        if (response.code) {
            response.tipMsg = [NSString stringWithFormat:@"%@,%li",@"访问失败",response.code];
        }
    }
    response.successed = httpCode==200&&response.code==0;
    response.networkStatus = networkStatus;
    return response;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n******************code --- %li\n******************errorMessage --- %@\n******************是否成功 --- %d\n****************** 内容 --- %@\n******************message --- %@\n",self.code,self.errorDesc , self.successed ,self.data,self.msg];
}


@end
