//
//  ViewController.m
//  LLImageBrowser
//
//  Created by wanglulu on 2017/8/10.
//  Copyright © 2017年 wanglulu. All rights reserved.
//

#import "ViewController.h"
#import "BaseCell.h"
#import "BaseLayout.h"
#define  ItemSize CGSizeMake(180, 180)
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *BaseCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_BaseCollectionView registerNib:[UINib nibWithNibName:@"BaseCell" bundle:nil] forCellWithReuseIdentifier:@"BaseCell"];
    BaseLayout *layout = [BaseLayout new];
    _BaseCollectionView.collectionViewLayout = layout;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.itemSize = ItemSize;
    layout.sectionInset = UIEdgeInsetsMake(0, (_BaseCollectionView.frame.size.width-ItemSize.width)/2, 0, (_BaseCollectionView.frame.size.width-ItemSize.width)/2);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}



#pragma mark --DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaseCell" forIndexPath:indexPath];
    cell.centerLabel.text =[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
    
}










@end
