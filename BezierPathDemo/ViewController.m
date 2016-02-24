//
//  ViewController.m
//  BezierPathDemo
//
//  Created by wangqiujia on 2/24/16.
//  Copyright © 2016 LiuChang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *circleShapeLayer;
@property (nonatomic, assign) CGRect       screenBounds;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //create red button
    self.screenBounds = [UIScreen mainScreen].bounds;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, CGRectGetWidth(self.screenBounds) - 20, 40)];
    [button addTarget:self action:@selector(startCircleAnimation) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"click me" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
    
    [self drawCircle];
    
    //create blue button
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, CGRectGetWidth(self.screenBounds) - 20, 40)];
    [button2 addTarget:self action:@selector(startLineAnimation) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"click me" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button2];
    
    [self drawCustomBezierPath];

}


- (void)drawCircle{
    self.circleShapeLayer = [CAShapeLayer layer];
//    UIBezierPath *circleBezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 350, 100, 100)];//在区域内绘制椭圆曲线
    UIBezierPath *circleBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.screenBounds) / 2 , 130) radius:60 startAngle:- M_PI / 2 endAngle:3 / 2. * M_PI clockwise:YES];
    [circleBezierPath setLineWidth:1];
    [self.circleShapeLayer setPath:circleBezierPath.CGPath];
    [self.circleShapeLayer setStrokeColor:[UIColor redColor].CGColor];
    [self.circleShapeLayer setFillColor:[UIColor clearColor].CGColor];
    [self.circleShapeLayer setBorderWidth:1];
    [self.view.layer addSublayer:self.circleShapeLayer];
}
- (void)startCircleAnimation{
    CABasicAnimation *circleBasicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    [circleBasicAnimation setFromValue:@0];
    [circleBasicAnimation setToValue:@1];
    [circleBasicAnimation setDuration:5];
    [self.circleShapeLayer addAnimation:circleBasicAnimation   forKey:@""];
}


//绘制曲线
- (void)drawCustomBezierPath{
    CGPoint startPoint      = CGPointMake(50, 400);
    CGPoint endPoint        = CGPointMake(300, 400);
    CGPoint controlPoint    = CGPointMake(175 / 2, 400 - 250 / 2);
    CGPoint controlPoint2    = CGPointMake(175 + 175 / 2, 400 + 100 / 2);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    self.shapeLayer = [CAShapeLayer layer];
    
    [path moveToPoint:startPoint];
    [path addCurveToPoint:endPoint controlPoint1:controlPoint controlPoint2:controlPoint2];
    
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    [self.shapeLayer setLineWidth:1];
    [self.view.layer addSublayer:self.shapeLayer];
}
- (void)startLineAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 1;
    [self.shapeLayer setLineWidth:4];
    [self.shapeLayer addAnimation:animation forKey:@""];
}


@end
