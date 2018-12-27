//
//  ApiManager.h
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RequestObject;

typedef void(^MYApiExampleFinished)(RequestObject *request,id result);

@interface ApiManager : NSObject

- (void)excuteGetList:(MYApiExampleFinished)finish;


- (void)cancelRequest:(NSString *)tag;

@end
