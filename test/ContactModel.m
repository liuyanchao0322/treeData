//
//  ContactModel.m
//  test
//
//  Created by 刘彦超 on 2018/5/11.
//  Copyright © 2018年 刘彦超. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel

- (NSMutableArray *)subNodes
{
    if (!_subNodes) {
        _subNodes = [NSMutableArray array];
    }
    return _subNodes;
}

@end
