//
//  LJBinarySearchTreeDemo.m
//  LJTree
//
//  Created by lijian on 19/5/26.
//  Copyright © 2019年 lijian. All rights reserved.
//

#import "LJBinarySearchTreeDemo.h"
#import "LJBinarySearchTree.h"
#import "MJBinaryTrees.h"
#import "LJBinaryTree.h"
#import "LJRBTree.h"
//
//@implementation LJBinarySearchTreeDemo
//
//- (void) test1 {
//    LJBinarySearchTree *bst = [LJBinarySearchTree treew]
//}
//
//
//@end
void test1() {
    
    //测试添加
//    int data[] = { 38, 18, 4, 69, 85, 71, 34, 36, 29, 100 };
    int data[] = { 38, 18, 4, 69, 85, 71, 34, 36, 29, 100,37,67,45,98,26,42,47,63,95,24,5,1,59,348,8765,45654,43,5643,23446,64,234,324};
    int len = sizeof(data) / sizeof(int);
    
    LJBinarySearchTree *bst = [LJBinarySearchTree treeWithComparetor:nil];
    for (int i = 0; i < len; i++) {
        [bst add:@(data[i])];
    }

    [MJBinaryTrees println:bst];
    
    
    //测试前驱和后继
    NSNumber *element = @(38);
    NSObject *pre = [bst pre:element];
    NSLog(@"%@的前驱节点是%@", element, pre);
    NSObject *suc = [bst suc:element];
    NSLog(@"%@的后继节点是%@", element, suc);
    
    //测试遍历
//    [bst inOrder:^(NSObject * element){
//        NSLog(@"%@   ", element);
//    }];
    
//    [bst postOrder:^(NSObject * element){
//        NSLog(@"%@   ", element);
//    }];
    
    //测试删除
    for (int i = 0; i < len; i++) {
        [bst remove:@(data[i])];
        [MJBinaryTrees println:bst];
    }
}


void test2() {
    
    //测试添加
    int data[] = { 38, 18, 4, 69, 85, 71, 34, 36, 29, 100,37,67,45,98,26,42,47,63,95,24,5,1,59,348,8765,45654,43,5643,23446,64,234,324};
//    int data[] = { 38, 18, 4, 69, 85, 71, 34, 36, 29, 100 };
    int len = sizeof(data) / sizeof(int);
    
    LJRBTree *bst = [LJRBTree treeWithComparetor:nil];
    for (int i = 0; i < len; i++) {
        //NSLog(@"..........添加的节点是%@...........",@(data[i]));
        [bst add:@(data[i])];
//        [MJBinaryTrees println:bst];
        //NSLog(@".........结束............");
    }
    
    [MJBinaryTrees println:bst];
    
    
    NSLog(@"........开始删除............");
    for (int i = 0; i < len; i++) {
        NSLog(@"..........添删除的节点是%@...........",@(data[i]));
        [bst remove:@(data[i])];
        [MJBinaryTrees println:bst];
        NSLog(@".........结束............");
    }

    
//    
//    //测试前驱和后继
//    NSNumber *element = @(38);
//    NSObject *pre = [bst pre:element];
//    NSLog(@"%@的前驱节点是%@", element, pre);
//    NSObject *suc = [bst suc:element];
//    NSLog(@"%@的后继节点是%@", element, suc);
//    
//    //测试遍历
//    //    [bst inOrder:^(NSObject * element){
//    //        NSLog(@"%@   ", element);
//    //    }];
//    
//    //    [bst postOrder:^(NSObject * element){
//    //        NSLog(@"%@   ", element);
//    //    }];
//    
//    //测试删除
//    [bst remove:@(38)];
//    [MJBinaryTrees println:bst];
    
}
