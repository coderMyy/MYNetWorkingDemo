//
//  NetWorkingConfig.h
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#ifndef NetWorkingConfig_h
#define NetWorkingConfig_h


//设置环境状态  1为正式域名  2为测试域名  3为预发布
#define SERVICE_TYPE  2

//只允许单账号登录   1为只允许单账号登录 ，其他数均为允许多账号登录
#define IMLOGIN_TYPE  1

//TCP版本号 依次累加
#define SOCKET_Version 1




//账号登录限制
#if IMLOGIN_TYPE == 1

#define ONLY_ONE_USE

#else
#endif

//服务器环境
#if SERVICE_TYPE == 1

#define PRODUCT_SERVICE

#elif SERVICE_TYPE == 2

#define TEST_SERVICE

#else

#define TEST_PREPARE

#endif

#ifdef  PRODUCT_SERVICE

// 正式接口
static  NSString *  baseUrl      = @"xxxxxx";

#endif

#ifdef TEST_SERVICE

static  NSString * baseUrl      = @"aaaaa";

#endif

#ifdef TEST_PREPARE

static  NSString * baseUrl      = @"1234";

#endif


#endif /* NetWorkingConfig_h */
