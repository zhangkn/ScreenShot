//
//  UIImage+KNClip.m
//  DrawingDemo
//
//  Created by mac on 2021/1/25.
//  Copyright © 2021 https://kunnan.blog.csdn.net  . All rights reserved.
//

#import "UIImage+KNClip.h"

@implementation UIImage (KNClip)

/**
 
 
 屏幕截图：
 
 方式一：
 调用某个view的layer的renderInContext:方法即可
 
 - (void)renderInContext:(CGContextRef)ctx;
 
 
 方式二：iOS7之后的推荐使用
 
 if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {

 */
+ (UIImage *)ScreenShotWithV:(UIView*)view imgw:(CGFloat)imgw{

        
    
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);

//    UIGraphicsBeginImageContext(view.bounds.size);
//       CGContextRef context = UIGraphicsGetCurrentContext();
     
       //将layer渲染到上下文
     
//       [view.layer renderInContext:context];
    
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        //Renders a snapshot of the complete view hierarchy as visible onscreen into the current context.

        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];// 在viewDidAppear的时候才会将视图渲染到上下文
    } else {
        //Renders the layer and its sublayers into the specified context.

        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }

     
       //获取新图片
     
       UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
     // 保存
//       NSData *data = UIImagePNGRepresentation(newImage);

    //       [data writeToFile:@"/Users/devzkn/Desktop/layer.png" atomically:YES];
    UIGraphicsEndImageContext();

//    return  newImage;
    return [self getWatermarkImaheWithImgae:newImage withWatermark:@"" watermarkColor:UIColor.clearColor imgw:imgw];// 进行等比例压缩图片

    

}
    
    
/**
 
 方式1: Uses the clipping path of the current graphics context to intersect the region that the path encloses, and makes the resulting shape the current clipping path.
 Declaration

 - (void)addClip;
 将当前上下所绘制的路径裁剪出来（超出这个裁剪区域的都不能显示）
 void CGContextClip(CGContextRef c);//

 
 
 
 
 方式2:裁剪感兴趣的部分Modifies the current clipping path by intersecting it with the specified rectangle.

 UIRectClip(textFrame);
 
 

 */
/*裁剪代码
 
 imgw： 图片宽， 此方法会根据imgw按照图片的原来宽高比进行缩放，计算对应的高
 */
 
+ (UIImage *)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)borderColor imgw:(CGFloat)imgw{
    
    
    

 // 1、根据视图的imgw 按照图片的原来宽高比进行缩放，计算对应高度
    UIImage *image = [UIImage imageNamed:name];//旧图片
    CGFloat imgh =imgw*image.size.height/image.size.width;//

    CGFloat borderWidth = border;//圆环高度

      
    //2、 开启上下文
    
    //新图片的大小

    CGFloat newImageW = imgw+borderWidth*2;
    CGFloat newImageH = imgh+borderWidth*2;

 
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newImageW, newImageH), NO, 0.0);
 
    //2.1>画大圆正切于矩形-----------
 
    

    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, newImageW,newImageH)];
 
    //获取当前上下文
 
    CGContextRef context = UIGraphicsGetCurrentContext();
 
    CGContextAddPath(context, path.CGPath);
 
    [borderColor set];
 
    CGContextFillPath(context);
 
    //绘制小圆
 
    //2.2>画一个正切于旧图片的小圆-----
 
    CGRect clipR = CGRectMake(borderWidth,borderWidth,imgw,imgh);
 
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipR];
 
    [clipPath addClip];//设置裁剪区域//Uses the clipping path of the current graphics context to intersect the region that the path encloses, and makes the resulting shape the current clipping path.

    
//    [image drawAtPoint:CGPointMake(borderWidth, borderWidth)];
 
    [image drawInRect:CGRectMake(borderWidth,borderWidth, imgw, imgh)];

    
    //2、获取上下文图片
 
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
 
     
 
    //3、结束上下文
 
    UIGraphicsEndImageContext();
 
    
    
    
    return newImage;
    
 
}





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



/**
 按照图片的原来宽高比进行缩放
 
 */
+ (UIImage*)getWatermarkImaheWithImgae:(UIImage*)image withWatermark:(NSString*)watermark watermarkColor:(UIColor*)watermarkColor imgw:(CGFloat)imgw{
    
    
    
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
