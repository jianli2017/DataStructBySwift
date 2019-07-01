//
//  LJNode.m
//  LJTree
//
//  Created by lijian on 19/5/26.
//  Copyright © 2019年 lijian. All rights reserved.
//

#import "LJNode.h"

@implementation LJNode

+ (instancetype) createNodeWithParent:(id) parent element:(id) element {
    LJNode *node = [[LJNode alloc] initWithParent:parent element:element];
    return node;
}

- (instancetype) initWithParent:(LJNode *) parent element:(NSObject*) element
{
    self = [super init];
    if (self) {
        self->_parent = parent;
        self->_element = element;
    }
    return self;
}

- (BOOL) isDegreeOne {
    if ((self->_left== nil&& self->_right != nil) || (self->_left != nil && self->_right == nil)) {
        return YES;
    }
    return NO;
}
- (BOOL)isLeftLeaf
{
    if (self->_parent && self == self->_parent->_left) {
        return YES;
    }
    return NO;
}
- (BOOL)isRightLeaf
{
    if (self->_parent && self== self->_parent->_right) {
        return YES;
    }
    return NO;
}

- (BOOL) hasTwoChildren {
    return  self->_left && self->_right;
}
@end
