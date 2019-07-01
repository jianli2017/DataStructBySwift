//
//  LJBinaryTree.h
//  LJTree
//
//  Created by lijian on 19/5/26.
//  Copyright © 2019年 lijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJNodeComparetor.h"
#import "LJNode.h"
#import "MJBinaryTreeInfo.h"

//普通二叉树
@interface LJBinaryTree : NSObject
{
@protected
    int _size; //树的大小
    LJNode *_root; //树的根节点
}

- (LJNode *) predecessor:(LJNode *)node ;

- (LJNode *) successor:(LJNode *) node;

-(void) preOrder:(void (^)(NSObject*)) visit;

-(void) inOrder:(void (^)(NSObject*)) visit;

-(void) postOrder:(void (^)(NSObject*)) visit;

//需要判断是否是完全二叉树， 层序遍历、 前序遍历的非递归实现
@end
