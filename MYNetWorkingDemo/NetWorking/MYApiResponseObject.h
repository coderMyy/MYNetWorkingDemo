//
//  MYApiResponseObject.h
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RealReachability.h"

@interface MYApiResponseObject : NSObject

@property (nonatomic, copy) NSString *msg;//服务器提供
@property (nonatomic, copy) NSString *tipMsg;//客户端提示
@property (nonatomic, assign) NSInteger httpCode;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, assign) BOOL successed;
@property (nonatomic, assign) ReachabilityStatus networkStatus;
@property (nonatomic, strong) id data;

+ (instancetype)creatResponse:(id)responsObj error:(NSError *)error task:(NSURLSessionDataTask *)task;

@end
