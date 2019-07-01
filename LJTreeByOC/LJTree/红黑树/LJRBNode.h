//
//  LJRBNode.h
//  LJTree
//
//  Created by lijian on 2019/5/28.
//  Copyright © 2019 lijian. All rights reserved.
//

#import <Foundation/Foundation.h>

static BOOL RED = NO;
static BOOL BLACK = YES;
//NS_ASSUME_NONNULL_BEGIN

@interface LJRBNode : NSObject
{
@public
    NSObject *_element;
    LJRBNode *_parent;
    LJRBNode *_left;
    LJRBNode *_right;
    BOOL _color;
}

+ (instancetype) createNodeWithParent:(id) parent element:(id) element;

//取出兄弟节点
- (LJRBNode *) sibling;

- (instancetype) initWithParent:(LJRBNode *) parent element:(NSObject*) element;

- (BOOL) isDegreeOne ;

- (BOOL)isRightLeaf; //自己是右节点？

- (BOOL)isLeftLeaf; //自己是左节点？

- (BOOL) hasTwoChildren; //判断是否有两个子节点

@end

//NS_ASSUME_NONNULL_END
