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
    _imgView.animationDuration = 20;
    [_imgView startAnimating];
    
    CGRect rect = CGRectMake(0, 2, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-4);
    DanmakuConfiguration *configuration = [[DanmakuConfiguration alloc]init];
    configuration.duration = 6.5;
    configuration.paintHeight = 21;
    configuration.fontSize = 17;
    configuration.largeFontSize = 19;
    configuration.maxLRShowCount = 30;
    configuration.maxShowCount = 45;
    _danmakuView = [[DanmakuView alloc]initWithFrame:rect Configuration:configuration];
    _danmakuView.delegate = self;
    [self.view insertSubview:_danmakuView aboveSubview:_imgView];
    
    // 引用字幕文件
    NSString *danmakufile = [[NSBundle mainBundle]pathForResource:@"danmakufile" ofType:nil];
    NSArray *danmakus = [NSArray arrayWithContentsOfFile:danmakufile];
    [_danmakuView prepareDanmakus:danmakus];
    
}

- (void)onTimeCount
{
    _slider.value += 0.1/120;
    if (_slider.value > 120.0) {
        _slider.value = 0;
    }
    [self onTimeChange:nil];
}

- (IBAction)onTimeChange:(id)sender {
    _curTime.text = [NSString stringWithFormat:@"%0.fs",_slider.value*120.0];
    
}

- (IBAction)onStartClick:(id)sender {
    if (_danmakuView.isPrepared) {
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimeCount) userInfo:nil repeats:YES];
        }
        [_danmakuView start];
    }
}

- (IBAction)onPauseClick:(id)sender {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [_danmakuView pause];
}

- (IBAction)onSendClick:(id)sender {
    int time = ([self danmakuViewGetPlayTime:nil]+1)*1000;
    int type = rand()%3;
    NSString *pString = [NSString stringWithFormat:@"%d,%d,1,00EBFF,125",time,type];
    NSString *mString = @"😊😊online.com😊😊";
    DanmakuSource *danmakeSource = [DanmakuSource createWithP:pString M:mString];
    [_danmakuView sendDanmakuSource:danmakeSource];
    
}

#pragma mark -
- (float)danmakuViewGetPlayTime:(DanmakuView *)danmakuView{
    return _slider.value*120.0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
