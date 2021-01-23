//
//  ViewController.m
//  DrawingDemo
//
//  Created by mac on 2021/1/23.
#import "KNCustomView.h"

#import "KNmatrixV.h"


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//(文字、圆、直线、弧线、矩形、扇形、椭圆、三角形、圆角矩形、贝塞尔曲线、图片)
    
    //1、、矩阵操作
//    [self test_matrixV];
    
    // 2、UILabel的使用演示显示模式
//    [self iOSDevloperLearn4UILabel];
    //3、各种图形(文字、圆、直线、弧线、矩形、扇形、椭圆、三角形、圆角矩形、贝塞尔曲线、图片)
    
    [self iOSDevloperLearn4CGContextRef];
    
}

- (void)iOSDevloperLearn4CGContextRef{
    
    
    
        KNCustomView *customView = [[KNCustomView alloc]initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, self.view.bounds.size.height)];
    customView.lineColor = UIColor.systemTealColor;
    
    customView.backgroundColor =UIColor.grayColor;

            [self.view addSubview:customView];
    

    
}

- (void)test_matrixV{
    
    KNmatrixV *customView = [[KNmatrixV alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.frame.size.height)];
        
        
            [self.view addSubview:customView];
    
        

}

//
- (void)iOSDevloperLearn4UILabel{
    
    
    // 1.1 创建UILabel对象
    UILabel *label = [[UILabel alloc] init];
    
    // 1.2 设置frame
    label.frame = CGRectMake(100, 100, self.view.bounds.size.width, 175);
    
    label.center = self.view.center;
    
    // 1.3 设置背景颜色
    label.backgroundColor = [UIColor grayColor];
    
    // 1.4 设置文字
    label.text = @"博客地址：https://kunnan.blog.csdn.net #公众号：iOS逆向 ";
//         label.text = @"#公众号：iOS逆向";

    
    // 1.5 居中
    label.textAlignment = NSTextAlignmentCenter;
    
    // 1.6 设置字体大小
//    label.font = [UIFont systemFontOfSize:20.f];
    label.font = [UIFont boldSystemFontOfSize:20.f];
//    label.font = [UIFont italicSystemFontOfSize:20.f];
    
    // 1.7 设置文字的颜色
    label.textColor = [UIColor systemPinkColor];
    
    // 1.8 设置阴影(默认是有值)
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(-2, 1);
    
    // 1.9 设置行数(0:自动换行)
    label.numberOfLines = 1;
    
    // 1.10 显示模式
    label.lineBreakMode =  NSLineBreakByTruncatingHead;
    
    /*
     NSLineBreakByWordWrapping = 0,  // 单词包裹,换行的时候会以一个单词换行
     NSLineBreakByCharWrapping,        // 字符包裹换行,换行的时候会以一个字符换行
     NSLineBreakByClipping,        // 裁剪超出的内容
     NSLineBreakByTruncatingHead,    // 一行中头部省略(注意:numberOfLines要为1): "...wxyz"
     NSLineBreakByTruncatingTail,    // 一行中尾部省略: "abcd..."
     NSLineBreakByTruncatingMiddle    // 一行中中间部省略:  "ab...yz"
     */
    
    
    // 2.0 添加到控制器的view中
    [self.view addSubview:label];

}

@end
