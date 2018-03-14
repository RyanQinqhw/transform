//
//  AffineTransformationViewController.m
//  transform
//
//  Created by 秦宏伟 on 2018/3/14.
//  Copyright © 2018年 明镜止水. All rights reserved.
//
#define RADIANS_TO_DEGREES(x) ((x) * M_PI / 180.0)
#import "AffineTransformationViewController.h"

@interface AffineTransformationViewController ()

    @property (nonatomic, strong) UIView *layerView;
    @property (nonatomic, strong) UIView *layerView1;
    
@end

@implementation AffineTransformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self.navigationController.navigationBar setTranslucent:NO]; //视图自动向下64
    [self.view addSubview:self.layerView];
    [self.view addSubview:self.layerView1];
    
    [self transform];
}

-(void)transform{
    // 带make
    CGAffineTransform transform = CGAffineTransformMakeRotation(RADIANS_TO_DEGREES(170));
    CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI / 180.0 * 45);
//    self.layerView.layer.backgroundColor = [UIColor redColor].CGColor;
    self.layerView.layer.affineTransform = transform;
//    self.layerView1.layer.affineTransform = transform1;
//    self.layerView.transform = transform;
    /*
        两种效果相同,小伙伴自行研究WHY????????
     */
    CGAffineTransform trans = CGAffineTransformIdentity;
    trans = CGAffineTransformScale(trans, 0.5, 0.5);
    trans = CGAffineTransformRotate(trans, M_PI / 180.0 * 30.0);
    trans = CGAffineTransformTranslate(trans, 200, 0);
    
    self.layerView1.layer.affineTransform = trans;
   
    

}
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(UIView *)layerView{
    if(!_layerView){
        _layerView = [UIView new];
        _layerView.frame = CGRectMake(30, 20, 100, 100);
        _layerView.backgroundColor = [UIColor blueColor];
    }
    return _layerView;
}
-(UIView *)layerView1{
    if(!_layerView1){
        _layerView1 = [UIView new];
        _layerView1.frame = CGRectMake(200, 20, 100, 100);
        _layerView1.backgroundColor = [UIColor blueColor];
    }
    return _layerView1;
}


@end
