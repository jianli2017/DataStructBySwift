//
//  LJNode.h
//  LJTree
//
//  Created by lijian on 19/5/26.
//  Copyright © 2019年 lijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJNode : NSObject

{
    @public
    NSObject *_element;
    LJNode *_parent;
    LJNode *_left;
    LJNode *_right;
}

+ (instancetype) createNodeWithParent:(id) parent element:(id) element;

- (instancetype) initWithParent:(LJNode *) parent element:(NSObject*) element;

- (BOOL) isDegreeOne ;

- (BOOL)isRightLeaf; //自己是右节点？

- (BOOL)isLeftLeaf; //自己是左节点？

- (BOOL) hasTwoChildren; //判断是否有两个子节点

@end
