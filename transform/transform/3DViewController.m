//
//  3DViewController.m
//  transform
//
//  Created by 秦宏伟 on 2018/3/14.
//  Copyright © 2018年 明镜止水. All rights reserved.
//

#import "3DViewController.h"

@interface _DViewController ()
@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) NSTimer *timer;
    @property (nonatomic, assign) NSInteger count;
@end

@implementation _DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view addSubview:self.layerView];
    self.count = 1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rotationView) userInfo:nil repeats:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}
-(void)rotationView{
//    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    if(self.count == 360){
        self.count = 1;
    }

    CATransform3D t = CATransform3DIdentity;
    t.m41 = 1 + self.count;
    t.m42 = t.m41;
    t = CATransform3DRotate(t, -M_PI / 180 * 1 * self.count, 1, 1, 1);
    t.m34 = -1.0 / 500.0;
    self.count++;
    self.layerView.layer.transform = t;
}


-(UIView *)layerView{
    if(!_layerView){
        _layerView = [UIView new];
        _layerView.frame = CGRectMake(30, 20, 70, 100);
        _layerView.backgroundColor = [UIColor grayColor];
        UILabel *label = [UILabel new];
        label.text = @"测试数据";
        [label sizeToFit];
        [_layerView addSubview:label];
    }
    return _layerView;
}
-(void)dealloc{
    NSLog(@"控制器销毁了");
}

@end
