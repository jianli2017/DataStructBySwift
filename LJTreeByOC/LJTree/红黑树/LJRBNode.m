//
//  LJRBNode.m
//  LJTree
//
//  Created by lijian on 2019/5/28.
//  Copyright © 2019 lijian. All rights reserved.
//

#import "LJRBNode.h"

@implementation LJRBNode

+ (instancetype) createNodeWithParent:(id) parent element:(id) element {
    LJRBNode *node = [[LJRBNode alloc] initWithParent:parent element:element];
    return node;
}

- (instancetype) initWithParent:(LJRBNode *) parent element:(NSObject*) element
{
    self = [super init];
    if (self) {
        self->_parent = parent;
        self->_element = element;
        self->_color = RED;
    }
    return self;
}

- (LJRBNode *) sibling {
    if ([self isLeftLeaf]) {
        return (LJRBNode *)_parent->_right;
    }
    if ([self isRightLeaf]) {
        return (LJRBNode *)_parent->_left;
    }
    return nil;
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
