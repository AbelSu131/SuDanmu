//
//  ViewController.m
//  SuDanmu
//
//  Created by AbelSu on 16/3/19.
//  Copyright © 2016年 AbelSu. All rights reserved.
//

#import "ViewController.h"

#import "DanmakuView.h"

@interface ViewController ()<DanmakuDelegate>{
    IBOutlet UIImageView *_imgView;
    IBOutlet UILabel *_curTime;
    IBOutlet UISlider *_slider;
    
    DanmakuView *_danmakuView;
    NSDate *_startDate;
    
    NSTimer *_timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *newArr = [NSMutableArray arrayWithCapacity:6];
    for (int i=0;i<6;i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
        [newArr addObject:img];
    }
    _imgView.animationImages = newArr;
    _
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
