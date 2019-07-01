//
//  LJBinaryTree.m
//  LJTree
//
//  Created by lijian on 19/5/26.
//  Copyright © 2019年 lijian. All rights reserved.
//

#import "LJBinaryTree.h"
//#include <queue>
//using namespace std;

@interface LJBinaryTree ()


@end



@implementation LJBinaryTree
/*
       ┌───38──┐
       │       │
    ┌─18─┐     69─┐
    │    │        │
    4  ┌─34─┐   ┌─85─┐
       │    │   │    │
      29    36 71   100
 */
//找前驱节点
- (LJNode *) predecessor:(LJNode *)node {
    
    if (!node) {// 如果为空，还找什么啊
        return nil;
    }
    
    // 前驱节点在左子树当中（left.right.right.right....）
    LJNode *predecessor = node->_left;
    if (predecessor) { //证明确实有左子树
        while (predecessor->_right) {
            predecessor= predecessor->_right;
        }
        return predecessor;
    }
    
    //走到这里，说明没有左子树，悲催了，找第一个左父节点,比如找29节点的前驱节点18
    predecessor = node;
    while (predecessor->_parent && predecessor == predecessor->_parent->_left) {
        predecessor = predecessor->_parent;
    }
    return predecessor->_parent;
}

//后继节点
- (LJNode *) successor:(LJNode *) node {
    if (!node) { //如果是空节点，没法找
        return nil;
    }
    LJNode *successor = node->_right;
    if (successor) { //前驱节点在左子树当中（right.left.left.left....）
        while (successor->_left) {
            successor = successor->_left;
        }
        return successor;
    }
    
    // 从父节点、祖父节点中寻找后继节点
    successor = node;
    while (successor->_parent && successor == successor->_parent->_right) {
        successor = successor->_parent;
    }
    return successor->_parent;
}

#pragma mark 遍历
//前序遍历，根节点、左子树、右子树
-(void) preOrder:(void (^)(NSObject*)) visit
{
    [self preOrder:_root visit:visit];
}

-(void) preOrder:(LJNode *) node visit:(void (^)(NSObject*)) visit
{
    if (!node) {
        return;
    }
    visit(node->_element);
    [self preOrder:node->_left visit:visit];
    [self preOrder:node->_right visit:visit];
}

//中序遍历，左子树、根节点、右子树
-(void) inOrder:(void (^)(NSObject*)) visit
{
    [self inOrder:_root visit:visit];
}

-(void) inOrder:(LJNode *) node visit:(void (^)(NSObject*)) visit
{
    if (!node) {
        return;
    }
    [self inOrder:node->_left visit:visit];
    visit(node->_element);
    [self inOrder:node->_right visit:visit];
}

//后序遍历，左子树、右子树、根节点
-(void) postOrder:(void (^)(NSObject*)) visit
{
    [self postOrder:_root visit:visit];
}

-(void) postOrder:(LJNode *) node visit:(void (^)(NSObject*)) visit
{
    if (!node) {
        return;
    }
    [self postOrder:node->_left visit:visit];
    [self postOrder:node->_right visit:visit];
    visit(node->_element);
}

//层序遍历
-(void) levelOrder:(void (^)(NSObject*)) visit
{
    if (!_root) {
        return;
    }
    [self levelOrder:_root visit:visit];
}

-(void) levelOrder:(LJNode *) node visit:(void (^)(NSObject*)) visit
{
}

@end
