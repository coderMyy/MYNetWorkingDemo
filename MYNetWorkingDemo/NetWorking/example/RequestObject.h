//
//  RequestObject.h
//  MYNetWorkingDemo
//
//  Created by 孟遥 on 2018/12/27.
//  Copyright © 2018年 孟遥. All rights reserved.
//

#import "MYApiRequestObject.h"

@interface RequestObject : MYApiRequestObject

//以下为所需参数
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *id;

@end
