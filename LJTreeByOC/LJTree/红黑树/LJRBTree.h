//
//  LJRBTree.h
//  LJTree
//
//  Created by lijian on 2019/5/28.
//  Copyright © 2019 lijian. All rights reserved.
//

#import "LJRBNode.h"
#import "LJNodeComparetor.h"
#import "MJBinaryTreeInfo.h"

NS_ASSUME_NONNULL_BEGIN

 /*
  红黑树的性质：
  1. 节点是有颜色的，要么RED，要么BLACK
  2. 根节点是BLACK
  3. 叶子节点（外部节点、空节点）都是BLACK
  4. RED节点的子节点都是BLACK
  5. 从任一节点到叶子节点的所有路径都包含相同数目的BLACK的节点
  */
/*
 BLACK 节点和它的红色子节点融合为一个B树节点
 红黑树的黑色节点树和4阶B树的总节点数相同
 */
@interface LJRBTree : NSObject <MJBinaryTreeInfo>

/*
 B数中，新元素必定是添加到叶子节点中
 4阶B树所有节点的元素个数x都符号1<x <3
 建议新添加的节点默认是RED，这样能够让红黑树的性质尽快满足
 
 添加总共有12种情况：
 如果添加的节点是根节点，染成BLACK即可
 有4种情况满足红黑树的性质，parent为BLACK
 有8种情况不满足红黑树性质，parent为RED（double RED）,其中前4种使B树上溢
 
 下面不会引起上溢的情况，判定条件uncle不是RED:
 LL、RR 构建一个B树节点 红黑红
 所以parent染BLACK grent 染红色 单旋转
 
 LR、RL 也是构建一个B树节点、红黑红
 自己染黑色 grand染红色 双旋转
 
 下面会引起上溢的情况，判定条件，uncle是红色：
 目标，向上合并grand，parend和uncle独立出两个节点
 LL：parent、uncle染成BLACK  grand向上合并， grand染为RED，当做新添加节点处理
 */

/* 删除的情况
 删除红色节点，不用处理，不影响红黑树性质
 
 1. 拥有两个红节点的黑节点，不需要处理，会找到他的子节点替代
 2. 拥有一个红节点的黑节点，（替代节点是红色）将替代节点染黑色 B树的3节点变2节点
 3. 单独的黑节点，导致B树下溢（先考虑借，后合并）
      a. 兄弟是黑色，有红节点（借）旋转，旋转后的中心节点继承原来的颜色，旋转后左右节点为黑色
      b. 兄弟是黑色，没有红色节点（合并吧），兄弟染红色，父节点黑色，如果父节点是黑色，导致父节点下溢，把父节点当做删除的节点继续搞
 
      兄弟为红色：兄弟染黑，父亲红，旋转 ，回到了ab的情况
 */
+ (instancetype) treeWithComparetor:(LJNodeComparetor) comparetor ;

-(void) add:(NSObject*) element;

-(void)remove:(NSObject *) element ;
@end

NS_ASSUME_NONNULL_END
