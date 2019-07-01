//
//  LJRBTree.m
//  LJTree
//
//  Created by lijian on 2019/5/28.
//  Copyright © 2019 lijian. All rights reserved.
//

#import "LJRBTree.h"

@interface LJRBTree ()
{
@protected
    int _size; //树的大小
    LJRBNode *_root; //树的根节点
    LJNodeComparetor _comparetor; // 元素比较器
}
@end


@implementation LJRBTree

+ (instancetype) treeWithComparetor:(LJNodeComparetor) comparetor {
    LJRBTree *RBTree = [[LJRBTree alloc] init];
    if (RBTree) {
//        RBTree->_comparetor = comparetor;
    }
    return RBTree;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self->_root = nil;
        self->_size = 0;
    }
    return self;
}

#pragma mark 添加
-(void) add:(NSObject*) element {
    if (!_root) {//空树，添加根节点
        _root = [LJRBNode createNodeWithParent:nil element:element];
        ++_size;
        [self afterAdd:_root];
        return;
    }
    //找到父节点
    LJRBNode *parent = _root;
    LJRBNode *node = _root; //遍历节点
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
    LJRBNode *newNode = [LJRBNode createNodeWithParent:parent element:element];
    if (cmp < 0) { //添加到左节点
        parent->_left = newNode;
    } else {
        parent->_right = newNode;
    }
    ++_size;
    [self afterAdd:newNode];
}

- (void) afterAdd:(LJRBNode *)node {
    
    LJRBNode *parent = (LJRBNode*)node->_parent;
    
    if (!parent) { //如果添加的是根节点，染BLACK
        [self black:node];
        return;
    }
    
    if ([self isBlack:parent]) { //如果父节点是黑色，直接返回
        return;
    }
    
    //上溢的情况,走到这里，parent肯定不为空
    LJRBNode *uncle = [node->_parent sibling];
    LJRBNode *grand = [self red:node->_parent->_parent] ; //可能为空?
    
    if ( [self isRed:uncle]) { // 叔父节点是红色【B树节点上溢】
        //叔父和父亲独立为两个B树节点，所以染BLACK
        [self black:uncle];
        [self black:parent];
        
        //祖父节点上溢
        [self afterAdd:grand];
        return;
    }
    
    // 叔父节点不是红色，就是构建一个B树超级节点
    if (parent.isLeftLeaf) { //L
        if ([node isLeftLeaf]) { //L
            [self black:parent];
        }
        else {
            [self black:node];
            [self rotateLeft:parent];
        }
        [self rotateRight:grand];
    } else { //R
        if ([node isLeftLeaf]) {
            [self black:node];
            [self rotateRight:parent];
        } else {
            [self black:parent];
        }
        [self rotateLeft:grand];
    }
}
#pragma mark 删除
-(void)remove:(NSObject *) element {
    if (!_root) {
        return;
    }
    //找到删除的节点
    LJRBNode *node = [self node:element];
    if (!node) {
        return;
    }
    
    //是度为2的节点
    if ([node hasTwoChildren]) {
        LJRBNode *suc = [self successor:node]; //找到node的后继节点
        node->_element = suc->_element;// 用后继节点的值覆盖度为2的节点的值
        node = suc; // 删除后继节点
    }
    
    LJRBNode *replacement = node->_left?node->_left:node->_right;
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
        [self afterRemove:replacement];
    } else if (node->_parent == nil) { // node是叶子节点并且是根节点
        _root = nil;
        [self afterRemove:node];
    } else { //处理度为0的节点
        if ([node isLeftLeaf]) {
            node->_parent->_left = nil;
        } else  {
            node->_parent->_right = nil;
        }
        [self afterRemove:node];
    }
    --_size;
}

-(void) afterRemove:(LJRBNode *) node {
    //删除的节点肯定是叶子节点
    
    // 如果删除的节点是红色
    // 或者 用以取代删除节点的子节点是红色
    if ([self isRed:node]) { //删除的是红色节点，不用处理
        [self black:node];
        return;
    }
    
    LJRBNode *parent = node->_parent;
    if (!parent) {// 删除的是根节点
        return;
    }
    
    BOOL left = parent->_left == nil || [node isLeftLeaf];
    LJRBNode *sibling = left?parent->_right:parent->_left;
    if (left) {
        if ([self isRed:sibling]) {
            [self black:sibling];
            [self red:parent];
            [self rotateLeft:parent];
            sibling = parent->_right;
        }
        
        //走到这里，说明兄弟必然是黑色
        
        //兄弟没有红色节点，下溢了
        if ([self isBlack:sibling->_left] && [self isBlack:sibling->_right]) {
            //这里说明一个问题，多用颜色判断
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            if (parentBlack) {
                [self afterRemove:parent];
            }
        } else {  // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if ([self isBlack:sibling->_right]) {
                [self rotateRight:sibling];
                sibling = parent->_right;
            }
            [self color:[self colorOf:parent] node:sibling];
            [self black:sibling->_right];
            [self black:parent];
            [self rotateLeft:parent];
        }
    } else { // 被删除的节点在右边，兄弟节点在左边
        if ([self isRed:sibling]) {
            [self black:sibling];
            [self red:parent];
            [self rotateRight:parent];
            sibling = parent->_left;
        }
        
        //走到这里，说明兄弟必然是黑色
        
        //兄弟没有红色节点，下溢了
        if ([self isBlack:sibling->_left] && [self isBlack:sibling->_right]) {
            //这里说明一个问题，多用颜色判断
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            if (parentBlack) {
                [self afterRemove:parent];
            }
        } else {  // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if ([self isBlack:sibling->_left]) {
                [self rotateLeft:sibling];
                sibling = parent->_left;
            }
            [self color:[self colorOf:parent] node:sibling];
            [self black:parent];
            [self black:sibling->_left];
            [self rotateRight:parent];
        }
    }
}

#pragma mark 旋转
- (void) rotateLeft:(LJRBNode*) grand {
    LJRBNode *parent = grand->_right;
    LJRBNode *child = parent ->_left;
    
    //基本旋转
    grand->_right = child;
    parent->_left = grand;
    
    [self rotateAfter:grand parent:parent child:child];
}

//结果是左子节点parend变为根节点
- (void) rotateRight:(LJRBNode*) grand {
    LJRBNode *parent = grand->_left;
    LJRBNode *child = parent->_right;
    
    grand->_left = child;
    parent->_right = grand;
    [self rotateAfter:grand parent:parent child:child];
    
}
- (void) rotateAfter:(LJRBNode*) grand parent:(LJRBNode*)parent child:(LJRBNode*) child
{
    //处理新的根节点parent的
    parent->_parent = grand->_parent;
    if ([grand isLeftLeaf]) {
        grand->_parent->_left = parent;
    } else if ([grand isRightLeaf]) {
        grand->_parent->_right = parent;
    } else {
        _root = parent; // parent是root节点
    }
    
    if (child) {
        child->_parent = grand;
    }
    
    grand->_parent = parent;// 更新grand的parent
}


#pragma mark 私有方法吧
//私有方法，返回节点值为element的节点
//找前驱节点
- (LJRBNode *) predecessor:(LJRBNode *)node {
    
    if (!node) {// 如果为空，还找什么啊
        return nil;
    }
    
    // 前驱节点在左子树当中（left.right.right.right....）
    LJRBNode *predecessor = node->_left;
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
- (LJRBNode *) successor:(LJRBNode *) node {
    if (!node) { //如果是空节点，没法找
        return nil;
    }
    LJRBNode *successor = node->_right;
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

- (LJRBNode *)node:(NSObject *) element {
    LJRBNode *node = _root;
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

//node是黑色节点吗
- (BOOL) isBlack:(LJRBNode*) node {
    return [self colorOf:node] == BLACK;
}
//node是红色节点吗
- (BOOL) isRed:(LJRBNode *) node {
    return [self colorOf:node] == RED;
}
//node颜色
- (BOOL) colorOf:(LJRBNode*) node {
    return node?node->_color:BLACK;
}
//给节点node着color色
- (LJRBNode *) color:(BOOL)color node:(LJRBNode*)node {
    if (node) {
        node->_color = color;
    }
    return node;
}

//给节点node着黑色
- (LJRBNode*) black:(LJRBNode*) node {
    return [self color:BLACK node:node];
}

//给节点node着红色
- (LJRBNode*) red:(LJRBNode*) node {
    return [self color:RED node:node];
}

#pragma mark - MJBinaryTreeInfo
- (id)left:(LJRBNode *)node {
    if (node) {
        return node->_left;
    }
    return nil;
}

- (id)right:(LJRBNode *)node {
    if (node) {
        return node->_right;
    }
    return nil;
}

- (id)string:(LJRBNode *)node {
    NSString *strColor = @"(R)";
    if ( [self isBlack:node]) {
        strColor = @"(B)";
    }
    if (node) {
        NSString *strP;
        if (node->_parent) {
            strP = [NSString stringWithFormat:@"%@",node->_parent->_element];
        }
        
        return [NSString stringWithFormat:@"%@_%@_(%@)",strColor,node->_element,strP];
    }
    else return nil;
    
    //    return node->_element;
}

- (id)root {
    return _root;
}

@end
