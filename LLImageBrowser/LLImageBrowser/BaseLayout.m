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
    
    NSArray *attrsAry = [super layoutAttributesForElementsInRect:CGRectMake(targetP.x, 0, self.collectionView.frame.size.width, 5000)];
    CGFloat max = MAXFLOAT;
   
    for( UICollectionViewLayoutAttributes *attrs in attrsAry  ){
        
        CGFloat reduceLength =((attrs.center.x-self.collectionView.contentOffset.x-self.collectionView.frame.size.width/2));
        NSLog(@"reduceLength = %f",reduceLength);
        if (fabs(max)>fabs(reduceLength)) {
            max = reduceLength;
        }
        
        
        
        

    }
    
    targetP.x += max;
    
   

    
    return targetP;
    
    
    
}


- (CGSize)collectionViewContentSize {
//    NSLog(@"size = %@",NSStringFromCGSize([super collectionViewContentSize]));
    return [super collectionViewContentSize];
}


@end
