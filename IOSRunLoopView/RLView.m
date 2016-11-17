//
//  RLView.m
//  IOSRunLoopView
//
//  Created by aa on 16/11/16.
//  Copyright © 2016年 aa. All rights reserved.
//

#import "RLView.h"

@interface RLView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *loopCollectionView;

@property (nonatomic,strong) NSMutableArray *afterImgAry;

@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation RLView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _loopCollectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        _loopCollectionView.backgroundColor = [UIColor blueColor];
        _loopCollectionView.delegate = self;
        _loopCollectionView.dataSource = self;
        _loopCollectionView.pagingEnabled = YES;
        _loopCollectionView.showsHorizontalScrollIndicator = NO;
        [_loopCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"mycollectioncell"];
        [self addSubview:_loopCollectionView];
        //添加指示器
        [self addSubview:self.pageControl];
    }
    return self;
}
//添加图片(懒加载)
- (NSMutableArray *)afterImgAry{
    if (!_afterImgAry) {
        _afterImgAry = [[NSMutableArray alloc]initWithArray:self.imgAry];
        [_afterImgAry insertObject:[self.imgAry lastObject] atIndex:0];
        [_afterImgAry addObject:[self.imgAry objectAtIndex:0]];
    }
    return _afterImgAry;
}
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
        _pageControl.numberOfPages = 5;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor brownColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}
//赋值
- (void)setImgAry:(NSArray *)imgAry{
    _imgAry = imgAry;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.afterImgAry.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycollectioncell" forIndexPath:indexPath];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imgView.image = [UIImage imageNamed:_afterImgAry[indexPath.item]];
    [cell.contentView addSubview:imgView];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(selectType:didSelectNum:)]) {
        [_delegate selectType:self didSelectNum:self.currentNumber];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = self.frame.size.width;
    
    //当滚动到倒数第一张，继续向后滚动
    if (scrollView.contentOffset.x > (self.afterImgAry.count-1)*width) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:1 inSection:0];
        [_loopCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    //当滚动到第一张图片时，继续向前滚动跳到最后一张
    if (scrollView.contentOffset.x < width*0.35) {
        NSIndexPath *index = [NSIndexPath indexPathForItem:self.imgAry.count inSection:0];
        [_loopCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    NSInteger currentPage = scrollView.contentOffset.x / width;
    self.currentNumber = currentPage - 1;
    if (self.currentNumber == self.imgAry.count) {
        self.currentNumber = 0;
    }
    NSLog(@"当前第%ld页",(long)self.currentNumber);
    self.pageControl.currentPage = self.currentNumber;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _loopCollectionView.frame = self.bounds;
    
    if (_loopCollectionView.contentOffset.x == 0) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:1 inSection:0];
        [_loopCollectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

@end
