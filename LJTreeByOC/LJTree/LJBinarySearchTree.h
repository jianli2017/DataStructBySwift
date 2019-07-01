//
//  LJBinarySearchTree.h
//  LJTree
//
//  Created by lijian on 19/5/26.
//  Copyright © 2019年 lijian. All rights reserved.
//

#import "LJBinaryTree.h"

//二叉搜索树
@interface LJBinarySearchTree : LJBinaryTree <MJBinaryTreeInfo>


+ (instancetype)treeWithComparetor:(LJNodeComparetor) comparetor;

//添加元素
-(void) add:(NSObject*) element;

//删除一个节点
-(void)remove:(NSObject *) element;

//找到前驱节点
- (NSObject*) pre:(NSObject*) element;

//找到后继节点
- (NSObject*) suc:(NSObject*) element;

#pragma mark 子类需要继承的
- (void) afterAdd:(LJNode *) node;

- (void) afterRemove:(LJNode *) node;


- (int)_compare:(id)element1 to:(id)element2;
- (LJNode *)node:(NSObject *) element;
@end
