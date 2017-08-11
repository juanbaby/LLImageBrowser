//
//  BaseLayout.m
//  LLImageBrowser
//
//  Created by wanglulu on 2017/8/10.
//  Copyright © 2017年 wanglulu. All rights reserved.
//

#import "BaseLayout.h"

@implementation BaseLayout

//准备约束item位置的时候调用,只有在第一加载和reload的时候调用

- (void)prepareLayout {
    [super prepareLayout];
    
}

//可是范围内的items信息
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attrsAry = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    for( UICollectionViewLayoutAttributes *attrs in attrsAry  ){
        
        CGFloat scale =1- fabs((attrs.center.x-self.collectionView.contentOffset.x-self.collectionView.frame.size.width/2))/(self.collectionView.frame.size.width/2)*0.2;

        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }

    
    return attrsAry;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    //    NSLog(@"------");
    return YES;
}





//滚动结束时的偏移量
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    NSArray *attrsAry = [super layoutAttributesForElementsInRect:CGRectMake(targetP.x, 0, self.collectionView.bounds.size.width, MAXFLOAT)];
    CGFloat max = MAXFLOAT;
   
    for( UICollectionViewLayoutAttributes *attrs in attrsAry  ){
        CGFloat reduceLength =((attrs.center.x-targetP.x-self.collectionView.frame.size.width*0.5));
        NSLog(@"reduceLength = %f",reduceLength);
        if (fabs(max)>fabs(reduceLength)) {
            max = reduceLength;
        }
        

    }
    
    targetP.x += max;
    NSLog(@"%f",targetP.x); 
    if (targetP.x <0) {
        targetP.x = 0;
    }
    
   

    
    return targetP;
    
    
//    // 拖动比较快 最终偏移量 不等于 手指离开时偏移量
//    CGFloat collectionW = self.collectionView.bounds.size.width;
//    
//    // 最终偏移量
//    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
//    
//    // 0.获取最终显示的区域
//    CGRect targetRect = CGRectMake(targetP.x, 0, collectionW, MAXFLOAT);
//    
//    // 1.获取最终显示的cell
//    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
//    
//    // 获取最小间距
//    CGFloat minDelta = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attr in attrs) {
//        // 获取距离中心点距离:注意:应该用最终的x
//        CGFloat delta = (attr.center.x - targetP.x) - self.collectionView.bounds.size.width * 0.5;
//        
//        if (fabs(delta) < fabs(minDelta)) {
//            minDelta = delta;
//        }
//    }
//    
//    // 移动间距
//    targetP.x += minDelta;
//    
//    if (targetP.x < 0) {
//        targetP.x = 0;
//    }
//    
//    return targetP;

    
    
    
}


//- (CGSize)collectionViewContentSize {
////    NSLog(@"size = %@",NSStringFromCGSize([super collectionViewContentSize]));
//    return [super collectionViewContentSize];
//}


@end
