//
//  ViewController.m
//  IOSRunLoopView
//
//  Created by aa on 16/11/16.
//  Copyright © 2016年 aa. All rights reserved.
//

#import "ViewController.h"
#import "RLView.h"

@interface ViewController ()<SelectItemDelegate>{
    NSArray *_arry;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arry = [[NSArray alloc]initWithObjects:@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg",@"05.jpg", nil];
    
    RLView *loopView = [[RLView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 200)];
    loopView.delegate = self;
    loopView.imgAry = _arry;
//    loopView.pageControlDirction = PageControlDirctionLeft;
    [self.view addSubview:loopView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)selectType:(RLView *)rotView didSelectNum:(NSUInteger)num{
    NSLog(@"select---:%lu",(unsigned long)num);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
