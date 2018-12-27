//
//  MYApiRequestObject.h
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import "MYApiRequestBaseObject.h"

@class MYApiRequestObject,MYApiResponseObject;
typedef void(^MYApiRequestFinishedCallback)(MYApiRequestObject *request,MYApiResponseObject *response);
typedef void(^MYApiRequestProgressCallback)(MYApiRequestObject *request,CGFloat progress);
@interface MYApiRequestObject : MYApiRequestBaseObject

- (void)sendRequest:(MYApiRequestFinishedCallback)finished progress:(MYApiRequestProgressCallback)progressBack;
- (void)cancelRequest;

@end
