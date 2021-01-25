//
//  KNWatermark.m
//  DrawingDemo
//
//  Created by mac on 2021/1/25.
//  Copyright © 2021 https://kunnan.blog.csdn.net  . All rights reserved.
//

#import "KNWatermark.h"

@implementation KNWatermark

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/

//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//
//
//}


/**
 添加图片水印：@公众号：iOS逆向
 
 1、开启一个基于位图的图形上下文
 void     UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale);
 
 @interface NSString(NSStringDrawing)
 - (void)drawAtPoint:(CGPoint)point withAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs API_AVAILABLE(macos(10.0), ios(7.0));

 2.从上下文中取得图片（UIImage）
  
 UIImage* UIGraphicsGetImageFromCurrentImageContext();
  
3.结束基于位图的图形上下文
 void     UIGraphicsEndImageContext();

 */
+ (UIImage*)getWatermarkImaheWithImgaeName:(NSString*)imgName withWatermark:(NSString*)watermark watermarkColor:(UIColor*)watermarkColor imgw:(CGFloat)imgw{
    
    
    
    /*要求：按照图片的原来宽高比进行缩放，满屏展示图片
     即按照图片的原宽高比例进行显示图片全部内容，并自动适应高度
     1、设置contentMode = UIViewContentModeScaleAspectFit
     2、图片视图的宽是固定的，第二部我们只要简单地处理自适应高度即可
     
     */
    UIImage *image = [UIImage imageNamed:imgName];
    
//    CGFloat imgw =self.view.bounds.size.width;// 满屏展示图片
    CGFloat imgh =imgw*image.size.height/image.size.width;
    
    
    
    
    //1、开启上下文：创建一个基于位图的上下文（context）,并将其设置为当前上下文(context)。
 /**
  参数size为新创建的位图上下文的大小。它同时是由UIGraphicsGetImageFromCurrentImageContext函数返回的图形大小。
  opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。

  scale—–缩放因子 iPhone 4是2.0，其他是1.0。
  虽然这里可以用[UIScreen mainScreen].scale来获取，但实际上设为0后，系统就会自动设置正确的比例了。

  */

    
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(imgw,imgh ), NO, 0.0);
    
     
    // 在坐标中画出图片
    [image drawInRect:CGRectMake(0, 0, imgw, imgh)];
    

//        [image drawAtPoint:CGPointZero];//保持图片大小在point点开始画图片
    
     //watermark
        [watermark drawAtPoint:CGPointMake(imgw*0.7, imgh*0.8) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:watermarkColor}];
    
     
        //2、获取上下文图片
     
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
     
        //3、结束上下文
     
        UIGraphicsEndImageContext();
     
    return newImage;
    
}





@end
