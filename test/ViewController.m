//
//  ViewController.m
//  test
//
//  Created by 刘彦超 on 2018/5/11.
//  Copyright © 2018年 刘彦超. All rights reserved.
//

#import "ViewController.h"
#import "ContactModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#warning pid == 0 的是跟节点
    ContactModel *node1 = [[ContactModel alloc] init];
    node1.Id = @"1";
    node1.pId = @"0";
    node1.isLeaf = @"0";
    
    
    ContactModel *node2 = [[ContactModel alloc] init];
    node2.Id = @"2";
    node2.pId = @"1";
    node2.isLeaf = @"0";

    
    ContactModel *node3 = [[ContactModel alloc] init];
    node3.Id = @"3";
    node3.pId = @"1";
    node3.isLeaf = @"0";
    
    ContactModel *node4 = [[ContactModel alloc] init];
    node4.Id = @"4";
    node4.pId = @"1"; // 3
    node4.isLeaf = @"1";
    
    ContactModel *node5 = [[ContactModel alloc] init];
    node5.Id = @"5";
    node5.pId = @"2";  // 1
    node5.isLeaf = @"1";
    
    ContactModel *node6 = [[ContactModel alloc] init];
    node6.Id = @"6";
    node6.pId = @"2";
    node6.isLeaf = @"0";

    ContactModel *node7 = [[ContactModel alloc] init];
    node7.Id = @"7";
    node7.pId = @"3"; // 4
    node7.isLeaf = @"1";

    ContactModel *node8 = [[ContactModel alloc] init];
    node8.Id = @"8";
    node8.pId = @"3"; // 5
    node8.isLeaf = @"1";

    ContactModel *node9 = [[ContactModel alloc] init];
    node9.Id = @"9";
    node9.pId = @"6";
    node9.isLeaf = @"0";

    ContactModel *node10 = [[ContactModel alloc] init];
    node10.Id = @"10";
    node10.pId = @"6"; // 2
    node10.isLeaf = @"1";

    ContactModel *node11 = [[ContactModel alloc] init];
    node11.Id = @"11";
    node11.pId = @"9"; // 6
    node11.isLeaf = @"1";
    
    ContactModel *node12 = [[ContactModel alloc] init];
    node12.Id = @"12";
    node12.pId = @"0";
    node12.isLeaf = @"0";
    
    ContactModel *node13 = [[ContactModel alloc] init];
    node13.Id = @"13";
    node13.pId = @"12";
    node13.isLeaf = @"1";
    
    NSArray *sourceNodes = @[node1,node2,node3,node4,node5,node6, node7,node8,node9,node10,node11,node12, node13];
    
    NSArray *contactRootNodes = [self sortNode:sourceNodes];
    // 跟节点
    NSLog(@"root nodes ===%@",contactRootNodes);
    
    // 勾选某个子节点返回这个子节点下的人
    NSArray *subContacts = [self countSubNodes:node1];
    NSLog(@"子节点下的人 == %@",subContacts);
}



#pragma mark - 自己理解写的
- (NSArray *)countSubNodes:(ContactModel *)node
{
    NSMutableArray *resultArray = [NSMutableArray array];
    for (ContactModel *subNode in node.subNodes) {
        if ([subNode.isLeaf isEqualToString:@"1"]) {
            if (![resultArray containsObject:subNode]) {
                [resultArray addObject:subNode];
            }
        } else {
            NSArray *nodeArray = [self countSubNodes:subNode];
            if (![resultArray containsObject:nodeArray]) {
                [resultArray addObjectsFromArray:nodeArray];
            }
        }
    }
    return resultArray;
}


- (NSMutableArray *)sortNodes:(NSArray *)sourceNodels
{
    NSMutableArray *resultArray = [NSMutableArray array];
    for (ContactModel *node1 in sourceNodels) {
        
        NSString *node1Id = node1.Id;
        for (ContactModel *node2 in sourceNodels) {
            if ([node1Id isEqualToString:node2.pId]) {
                if (![node1.subNodes containsObject:node2]) {
                    [node1.subNodes addObject:node2];
                }
            }
        }
        [resultArray addObject:node1];
    }
    
    NSMutableArray *rootNodeArray = [NSMutableArray array];
    for (ContactModel *rootNode in resultArray) {
        if ([rootNode.pId isEqualToString:@"0"]) {
            if (![rootNodeArray containsObject:rootNode]) {
                [rootNodeArray addObject:rootNode];
            }
        }
    }
    return rootNodeArray;
}





#pragma mark - 原来的
/**
 * 勾选某个子节点返回这个子节点下的人
 */
- (NSArray *)countSubnode:(ContactModel *)node {
    
    NSMutableArray *subNodes = [NSMutableArray new];
    
    ContactModel *curnode = node;
    
    for (ContactModel *node in curnode.subNodes) {
        
        if ([node.isLeaf isEqualToString:@"1"]) { // 没有子节点，添加到数组里
            
            [subNodes addObject:node];
            
        } else { //有子节点,接着遍历
            NSArray *result = [self countSubnode:node];
            [subNodes addObjectsFromArray:result];
        }
    }
    return subNodes;
}




/** 把数据还原成树形结构
 *  sourceNodes : 原数据
 *  return : 树形结构的数据
 */
- (NSArray *)sortNode:(NSArray *)sourceNodes {
    
    NSMutableArray *rootNodes = nil;
    @try {
        
        NSMutableArray *resultNodes = [NSMutableArray array];
        
        for (ContactModel *nodeloop1 in sourceNodes) {
            
            NSString *nodeid = nodeloop1.Id;
            
            for (ContactModel *nodeloop2 in sourceNodes) {
                
                if ([nodeid isEqualToString:nodeloop2.pId]) { // 当 nodeid == nodeloop2.pId时，证明nodeloop2.pId的父节点就是 nodeid，把nodeloop2添加到nodeLoop1 的subNodes里
                    
                    [nodeloop1.subNodes addObject:nodeloop2];
                }
            }
            // 存放所有有子节点的数据
            [resultNodes addObject:nodeloop1];
        }
        
        // 存放跟节点的数组
        rootNodes = [NSMutableArray array];
        
        for (ContactModel *node in resultNodes) { // 遍历所有有子节点的数据，当node的 pId== # 时，就是跟节点
            
            NSString *pid = node.pId;
            if ([pid isEqualToString:@"0"]) { // 真正数据时这改成 #
                [rootNodes addObject:node];
            }
    
            BOOL success = [self insertNode:node intoNodeTree:resultNodes];

            if (!success) {
                NSLog(@"current node is root node");
            }
        }
        
    } @catch (NSException *except){
        NSLog(@"--%@",except);
    }
    return rootNodes;
}


- (BOOL)insertNode:(ContactModel *)node intoNodeTree:(NSArray *)nodeTree {
    
    BOOL result = NO;
    NSString *nodeid = node.Id;
    for (ContactModel *treeNode in nodeTree) {
        if ([nodeid isEqualToString:treeNode.Id]) {
            treeNode.subNodes = node.subNodes;
            result = YES;
            break;
        } else {
            if (treeNode.subNodes && treeNode.subNodes.count > 0) { // 有子节点
                result = [self insertNode:node intoNodeTree:treeNode.subNodes];
            }
        }
    }
    return result;
}





@end
