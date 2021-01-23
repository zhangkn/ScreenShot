//
//  KNmatrixV.m
//  DrawingDemo
//
//  Created by mac on 2021/1/23.
//  Copyright © 2021 https://kunnan.blog.csdn.net  . All rights reserved.
//

#import "KNmatrixV.h"

@implementation KNmatrixV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
/**
 上下文的矩阵操作：修改上下文的形变
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
 
    //平移上下文
 
    CGContextTranslateCTM(context, 50, 100);
 //      旋转

    CGContextRotateCTM(context, M_PI_4);
 //      缩放

    CGContextScaleCTM(context, 0.2, 0.7);
 //      注意:上下文操作必须得要在添加路径之前去设置
    //上下文的矩阵操作之后再设置绘图信息（路径）

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-50, -100, 120, 100)];
 
    CGContextAddPath(context, path.CGPath);
 
    [[UIColor yellowColor]set];
 
    CGContextStrokePath(context);

}

@end
