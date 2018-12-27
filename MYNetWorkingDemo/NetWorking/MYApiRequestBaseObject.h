//
//  MYApiRequestBaseObject.h
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MY_APIREQUEST_TYPE){
    
    MYApiRequestGetType = 0,
    MYApiRequestPostType = 1
};
@interface MYApiRequestBaseObject : NSObject

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, assign) BOOL localCache;
@property (nonatomic, strong) NSURLSessionDataTask *task;

- (NSString *)requestTag;
- (NSInteger)timeout;
- (NSString *)urlString;
- (MY_APIREQUEST_TYPE)requestType;

+ (instancetype)creatRequest:(MY_APIREQUEST_TYPE)requestType urlString:(NSString *)urlString timeout:(NSInteger)timeout requestTag:(NSString *)tag;
- (instancetype)initWithRequest:(MY_APIREQUEST_TYPE)requestType urlString:(NSString *)urlString timeout:(NSInteger)timeout requestTag:(NSString *)tag;

@end
