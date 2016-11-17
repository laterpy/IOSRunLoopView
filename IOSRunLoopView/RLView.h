//
//  RLView.h
//  IOSRunLoopView
//
//  Created by aa on 16/11/16.
//  Copyright © 2016年 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RLView;

@protocol SelectItemDelegate <NSObject>

- (void)selectType:(RLView *)rotView didSelectNum:(NSUInteger)num;

@end

typedef NS_ENUM(NSInteger,PageControlDirction){
    PageControlDirctionLeft,
    PageControlDirctionCenter,
    PageControlDirctionRight,
};

@interface RLView : UIView

@property (nonatomic,strong) NSArray *imgAry;//传入本地图片数组

@property (nonatomic,assign) NSInteger currentNumber;//当前滚动到第几个

@property (nonatomic,weak) id<SelectItemDelegate>delegate;

@property (nonatomic,assign) PageControlDirction pageControlDirction;

@end
