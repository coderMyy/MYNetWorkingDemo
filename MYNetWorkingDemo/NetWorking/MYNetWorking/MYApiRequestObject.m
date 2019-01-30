//
//  MYApiRequestObject.m
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import "MYApiRequestObject.h"
#import "MYNetWorkingTool.h"

@implementation MYApiRequestObject

- (void)sendRequest:(MYApiRequestFinishedCallback)finished progress:(MYApiRequestProgressCallback)progressBack
{
    if (self.requestType == MYApiRequestGetType) {
        
        self.task = [MYNetWorkingTool excuteGetRequest:self progress:^(CGFloat progress) {
            if (progressBack) {
                progressBack(self,progress);
            }
        } finished:^(MYApiResponseObject *response) {
            if (finished) {
                finished(self,response);
            }
        }];
        
    }else if (self.requestType == MYApiRequestPostType){
        
        self.task = [MYNetWorkingTool excutePostRequest:self progress:^(CGFloat progress) {
            if (progressBack) {
                progressBack(self,progress);
            }
        } finished:^(MYApiResponseObject *response) {
            if (finished) {
                finished(self,response);
            }
        }];
    }
}

- (void)cancelRequest
{
    [self.task cancel];
}


@end
