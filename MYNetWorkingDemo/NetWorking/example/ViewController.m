//
//  ViewController.m
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import "ViewController.h"
#import "MYApiManager.h"
#import "RequestObject.h"
#import "ApiManager.h"

@interface ViewController ()<MYApiRequestDelegate>

@property (nonatomic, strong) MYApiManager *apiManager;

@property (nonatomic, strong) ApiManager *api;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //使用方法一 (VC里直接使用)
    [self loadData];
    
    //使用方法二 (二次封装，自己再封装一层到ApiManager里)
    [self loadData1];
    
    
    
    //注： 代理式 和block各有优缺点 。代理式，请求结果可以统一在代理方法中处理，block则各个请求处理方式相对独立。
    
    //使用方式：1.creatRequest方法创建一个继承于 MYApiRequestObject 的请求实例，并自行设定需要的参数属性  2.引用MYApiManager对象 ，excuteRequest执行请求 。3. 通过代理或者block方式，进行处理请求结果。
    
}


- (void)loadData
{
    
    //代理式
    RequestObject *request = [RequestObject creatRequest:MYApiRequestGetType urlString:@"user/user/activity" timeout:10 requestTag:@"list"];
    request.id = @"测试id";
    request.type = @"测试类型";
    request.baseUrl = @"自定义基础域名"; //如果要应对服务器多个域名开发，可以自行更改baseUrl
    request.localCache = YES; //是否需要本地数据缓存 (暂未实现)
    [self.apiManager excuteRequest:request];
    
    //根据设定的tag取消请求
    [self.apiManager excuteCancelRequest:@"list"];
    
    RequestObject *request111 = [RequestObject creatRequest:MYApiRequestGetType urlString:@"user/user/activity" timeout:10 requestTag:@"list"];
    request111.id = @"测试id";
    request111.type = @"测试类型";
    [self.apiManager excuteRequest:request111];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        RequestObject *request1 = [RequestObject creatRequest:MYApiRequestPostType urlString:@"praise/create" timeout:30 requestTag:@"like"];
        request1.id = @"测试id";
        request1.type = @"测试类型";
        [self.apiManager excuteRequest:request1];
        
    });
    
    
    //block式
    RequestObject *request2 = [RequestObject creatRequest:MYApiRequestGetType urlString:@"user/user/activity" timeout:10 requestTag:@"list"];
    request2.id = @"测试id";
    request2.type = @"测试类型";
    [self.apiManager excuteRequest:request2 finished:^(MYApiRequestObject *request, MYApiResponseObject *response) {
        NSLog(@"请求完成了");
    } progress:^(MYApiRequestObject *request, CGFloat progress) {
        NSLog(@"-----进度-----%f",progress);
    }];
}


- (void)loadData1
{
    //对MYApiManager进行二次封装，在自己的apiManager里可以自行处理异常或者数据等
    [self.api excuteGetList:^(MYApiRequestObject *request, id result) {
        RequestObject *rq = (RequestObject *)request;
    }];
}



#pragma apiDelegate
- (void)requestFinished:(MYApiRequestObject *)request response:(MYApiResponseObject *)response
{
    if ([request.requestTag isEqualToString:@"list"]) { //列表
        
        //成功处理
        if (response.successed) {
            
            
            NSLog(@"xxx--xxx");
            
        //失败处理
        }else{
            
            //1. 蒙板处理
            //2. 提示语为例
        }
        
    }else if ([request.requestTag isEqualToString:@"like"]){ //点赞
        
        NSLog(@"111---1111");
    }
}

//网络实时监听
- (void)networkRealtimeCheck:(ReachabilityStatus)status
{
    
}

- (MYApiManager *)apiManager
{
    if (!_apiManager) {
        _apiManager = [[MYApiManager alloc]init];
        _apiManager.delegate = self;
    }
    return _apiManager;
}

- (ApiManager *)api
{
    if (!_api) {
        _api = [ApiManager new];
    }
    return _api;
}




@end
