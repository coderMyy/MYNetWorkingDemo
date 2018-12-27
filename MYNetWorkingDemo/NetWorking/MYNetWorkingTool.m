//
//  MYNetWorkingTool.m
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import "MYNetWorkingTool.h"
#import "AFHTTPSessionManager.h"
#import "MYApiRequestObject.h"

@interface MYNetWorkingTool ()

@property (nonatomic,strong)AFHTTPSessionManager *manager;

@end

static MYNetWorkingTool *baseNetWork;
@implementation MYNetWorkingTool

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseNetWork = [[MYNetWorkingTool alloc]init];
    });
    return baseNetWork;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        sessionManager.responseSerializer = responseSerializer;
        [sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        sessionManager.requestSerializer.timeoutInterval = 30.f;
        [sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                         @"text/html",
                                                                                         @"text/json",
                                                                                         @"text/plain",
                                                                                         @"text/javascript",
                                                                                         @"text/xml",
                                                                                         @"image/*",
                                                                                         @"application/x-www-form-urlencoded"]];
        sessionManager.operationQueue.maxConcurrentOperationCount = 3;
        /*
         NSURL * url = [NSURL URLWithString:@"https://www.google.com"];
         AFHTTPRequestOperationManager * requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
         dispatch_queue_t requestQueue = dispatch_create_serial_queue_for_name("kRequestCompletionQueue");
         requestOperationManager.completionQueue = requestQueue;
         
         AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
         
         //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
         //如果是需要验证自建证书，需要设置为YES
         securityPolicy.allowInvalidCertificates = YES;
         
         //validatesDomainName 是否需要验证域名，默认为YES；
         //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
         //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
         //如置为NO，建议自己添加对应域名的校验逻辑。
         securityPolicy.validatesDomainName = YES;
         
         //validatesCertificateChain 是否验证整个证书链，默认为YES
         //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
         //GeoTrust Global CA
         //    Google Internet Authority G2
         //        *.google.com
         //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
         //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证，因为整个证书链一一比对是完全没有必要（请查看源代码）；
         securityPolicy.validatesCertificateChain = NO;
         
         requestOperationManager.securityPolicy = securityPolicy;*/
        /**********************************************/
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = NO;
        securityPolicy.validatesDomainName = YES;
        sessionManager.securityPolicy = securityPolicy;
        /**********************************************/
        _manager = sessionManager;
    }
    //请求头
    //    [self setHtttpCommonHeader:_manager];
    return _manager;
}


+ (NSURLSessionDataTask *)excuteGetRequest:(MYApiRequestObject *)request progress:(MYNetWorkingProgressCallback)progress
                                  finished:(MYNetWorkingFinishedCallback)finished
{
    
    AFHTTPSessionManager *manager = [MYNetWorkingTool sharedInstance].manager;
    manager.requestSerializer.timeoutInterval = request.timeout;
    NSString *url = [NSString stringWithFormat:@"%@%@",request.baseUrl,request.urlString];//
    return [manager GET:url parameters:request.yy_modelToJSONObject progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            CGFloat postProGress = (CGFloat)(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            progress(postProGress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MYApiResponseObject *obj = [MYApiResponseObject creatResponse:responseObject error:nil task:task];
        finished(obj);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MYApiResponseObject *obj = [MYApiResponseObject creatResponse:nil error:error task:task];
        finished(obj);
    }];
}

+ (NSURLSessionDataTask *)excutePostRequest:(MYApiRequestObject *)request progress:(MYNetWorkingProgressCallback)progress
                                   finished:(MYNetWorkingFinishedCallback)finished
{
    AFHTTPSessionManager *manager = [MYNetWorkingTool sharedInstance].manager;
    manager.requestSerializer.timeoutInterval = request.timeout;
    NSString *url = [NSString stringWithFormat:@"%@%@",request.baseUrl,request.urlString];
    return [manager POST:url parameters:request.yy_modelToJSONObject progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            CGFloat postProGress = (CGFloat)(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            progress(postProGress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MYApiResponseObject *obj = [MYApiResponseObject creatResponse:responseObject error:nil task:task];
        finished(obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MYApiResponseObject *obj = [MYApiResponseObject creatResponse:nil error:error task:task];
        finished(obj);
    }];
}


@end
