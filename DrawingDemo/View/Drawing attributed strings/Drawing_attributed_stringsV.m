//
//  Drawing_attributed_stringsV.m
//  DrawingDemo
//
//  Created by mac on 2021/1/23.
//Drawing attributed strings that are both filled and stroked

//import <CoreData/CoreData.h>
#import "Drawing_attributed_stringsV.h"

@implementation Drawing_attributed_stringsV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
//Draw the string
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSString    *string = @"公众号：iOS逆向";

    NSMutableDictionary *stringAttributes = [NSMutableDictionary dictionary];
 
    // Define the font and fill color Arial-BoldMT (字体)
//    [stringAttributes setObject:[UIFont fontWithName:@"Arial-BoldMT" size:44] forKey: NSFontAttributeName];
    [stringAttributes setObject:[UIFont fontWithName:@"Arial-BoldMT" size:18] forKey: NSFontAttributeName];

    //(字体颜色)
    [stringAttributes setObject: [UIColor whiteColor] forKey: NSForegroundColorAttributeName];
    
 //(边线宽度)
    // Supply a negative value for stroke width that is 2% of the font point size in thickness
    [stringAttributes setObject: [NSNumber numberWithFloat: -2.0] forKey: NSStrokeWidthAttributeName];
    /// (边线颜色)
    [stringAttributes setObject: [UIColor blackColor] forKey: NSStrokeColorAttributeName];
 
    // Paint the background
    [[UIColor grayColor] set];
    
    [UIBezierPath  bezierPathWithRect: [self bounds]];
    
    
 
    // Draw the string
//    [string drawInRect: self.frame withAttributes: stringAttributes];
    
    [string drawAtPoint: CGPointMake(100, 100) withAttributes: stringAttributes];


    
}



@end
