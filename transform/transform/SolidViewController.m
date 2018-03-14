//
//  SolidViewController.m
//  transform
//
//  Created by 秦宏伟 on 2018/3/14.
//  Copyright © 2018年 明镜止水. All rights reserved.
//

#import "SolidViewController.h"
#import <GLKit/GLKit.h> //计算向量框架

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5


@interface SolidViewController ()
    @property (nonatomic, strong) NSMutableArray *array;
    @property (nonatomic, strong) UIView *containerView;
@end

@implementation SolidViewController

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform{
    UIView *face = self.array[index];
    face.layer.transform = transform;
    [self applyLightingToFace:face.layer];
}

- (void)applyLightingToFace:(CALayer *)face{
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *((GLKMatrix4 *)&transform);
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);

     normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
    
                      
    
    
}
    

    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.array = [NSMutableArray array];
    self.containerView = [UIView new];
    self.containerView.frame = CGRectMake(20, 20, 300, 300);
    self.containerView.backgroundColor = [UIColor cyanColor];
    for (int i = 0; i < 6; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(100, 100, 100, 100);
        view.backgroundColor = [UIColor redColor];
        UIView *subView = [[UIView alloc] init];
        subView.frame = CGRectMake(25, 25, 50, 50);
        subView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [UILabel new];
        label.text  = [NSString stringWithFormat:@"%d",i + 1];
        [label sizeToFit];
        [subView addSubview:label];
        [view addSubview:subView];
        [self.containerView addSubview:view];
//        [self.view addSubview:view];
        [self.array addObject:view];
    }
    [self.view addSubview:self.containerView];
    
    [self solid3D];
}


-(void)solid3D{
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    
    
     //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 50);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(50, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -50, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
//    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 50, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
//    //add cube face 5
    transform = CATransform3DMakeTranslation(-50, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
//    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -50);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    

    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0); //子试图X轴旋转45
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0); //子试图Y轴旋转45
    
    self.containerView.layer.sublayerTransform = perspective;
  
}
    
    
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
