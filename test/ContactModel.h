//
//  ContactModel.h
//  test
//
//  Created by 刘彦超 on 2018/5/11.
//  Copyright © 2018年 刘彦超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
/** id */
@property (nonatomic, copy) NSString *Id;
/** 父Id: 当 pid == 0 时代表跟节点 */
@property (nonatomic, copy) NSString *pId;
/** 是否是叶子节点 1:是，下边没有子节点  0: 不是，下边有子节点*/
@property (nonatomic, copy) NSString *isLeaf;
/** 叶签下所有的人 */
@property (nonatomic, strong) NSMutableArray *subNodes;
/** 是否选中 */
@property (nonatomic, assign) BOOL isSelect;

@end
