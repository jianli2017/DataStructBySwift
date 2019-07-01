//
//  LJBinarySearchTree.m
//  LJTree
//
//  Created by lijian on 19/5/26.
//  Copyright © 2019年 lijian. All rights reserved.
//

#import "LJBinarySearchTree.h"
#import "LJNode.h"
#import "MJBinaryTreeInfo.h"


@interface LJBinarySearchTree ()
{
    LJNodeComparetor _comparetor; // 元素比较器 
}

@end
@implementation LJBinarySearchTree

+ (instancetype) treeWithComparetor:(LJNodeComparetor) comparetor{
    LJBinarySearchTree *binaryTree = [[LJBinarySearchTree alloc] init];
    if (binaryTree) {
        binaryTree->_comparetor = comparetor;
    }
    return binaryTree;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self->_root = nil;
        self->_size = 0;
    }
    return self;
}

#pragma mark 添加删除
//添加元素
-(void) add:(NSObject*) element {
    if (!_root) {//空树，添加根节点
        _root = [LJNode createNodeWithParent:nil element:element];
        ++_size;
        [self afterAdd:_root];
        return;
    }
    
    
    //找到父节点
    LJNode *parent = _root;
    LJNode *node = _root; //遍历节点
    int cmp = 0;
    do{
        cmp = [self _compare:element to:node->_element];
        parent = node;
        if (cmp<0) {
            node = node->_left;
        } else if(cmp > 0) {
            node = node->_right;
        } else
        {
            node->_element = element;
            return;
        }
    } while (node);
    
    //添加节点
    LJNode *newNode = [LJNode createNodeWithParent:parent element:element];
    if (cmp < 0) { //添加到左节点
        parent->_left = newNode;
    } else {
        parent->_right = newNode;
    }
    ++_size;
}
- (void) afterAdd:(LJNode *)node {
    
}

-(void)remove:(NSObject *) element {
    if (!_root) {
        return;
    }
    
    //找到删除的节点
    LJNode *node = [self node:element];
    if (!node) {
        return;
    }
    
    //是度为2的节点
    if ([node hasTwoChildren]) {
        LJNode *suc = [self successor:node]; //找到node的后继节点
        node->_element = suc->_element;// 用后继节点的值覆盖度为2的节点的值
        node = suc; // 删除后继节点
    }
    
    LJNode *replacement = node->_left?node->_left:node->_right;
    if (replacement) { //处理度为1的情况
        replacement->_parent = node->_parent;
        if ([node isRightLeaf]) {
            node->_parent->_right = replacement;
        }
        else if ([node isLeftLeaf]) {
            node->_parent->_left = replacement;
        } else {//删除根节点，根节点设置为replacement
            _root = replacement;
        }
    } else if (node->_parent == nil) { // node是叶子节点并且是根节点
        _root = nil;
    } else { //处理度为0的节点
        if ([node isLeftLeaf]) {
            node->_parent->_left = nil;
        } else  {
            node->_parent->_right = nil;
        }
    }
    --_size;
}

#pragma mark 前驱后继
//找到前驱节点
- (NSObject*) pre:(NSObject*) element {
    LJNode *node = [self node:element];
    if (node) {
        LJNode * pre = [super predecessor:node];
        return pre->_element;
    } else {
        return nil;
    }
}


//找到后继节点
- (NSObject*) suc:(NSObject*) element {
    LJNode *node = [self node:element];
    if (node) {
        LJNode * suc = [super successor:node];
        return suc->_element;
    } else {
        return nil;
    }
}


#pragma mark 私有方法
//私有方法，返回节点值为element的节点
- (LJNode *)node:(NSObject *) element {
    LJNode *node = _root;
    while (node) {
        int cmp = [self _compare:element to:node->_element];
        if (cmp < 0) {
            node = node->_left;
        } else if (cmp>0) {
            node = node->_right;
        } else {
            break;
        }
    }
    return node;
}


- (int)_compare:(id)element1 to:(id)element2 {
    if (_comparetor) {
        return _comparetor(element1,element2);
    }
    else {
        return [element1 compare:element2];
    }
    //return _comparatorBlock ? _comparatorBlock(e1, e2) :
    //(_comparator ? [_comparator compare:e1 another:e2] : [e1 compare:e2]);
}

#pragma mark - MJBinaryTreeInfo
- (id)left:(LJNode *)node {
    if (node) {
        return node->_left;
    }
    return nil;
}

- (id)right:(LJNode *)node {
    if (node) {
        return node->_right;
    }
    return nil;
}

- (id)string:(LJNode *)node {
    if (node) {
        return node->_element;
    }
    return nil;
    
}

- (id)root {
    return _root;
}


@end
