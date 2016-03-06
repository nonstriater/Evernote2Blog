//
//  UIWebView+addtions.m
//  Olla
//
//  Created by null on 15-3-20.
//  Copyright (c) 2015年 xiaoran. All rights reserved.
//

#import "UIWebView+addtions.h"

@implementation UIWebView (addtions)

// 需要主线程执行
// 如果content内容大，大图将会占用较大内存
- (UIImage *)screenshot{

    UIGraphicsBeginImageContextWithOptions(self.scrollView.contentSize, NO, 0);
    CGPoint oldContentOffset = self.scrollView.contentOffset;
    CGRect oldFrame = self.scrollView.frame;
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.frame = CGRectMake(0.f, 0.f, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    [self.scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    self.scrollView.contentOffset = oldContentOffset;
    self.scrollView.frame = oldFrame;
    UIGraphicsEndImageContext();
    return image;
    
}


- (UIImage *)screeshotPro{

    CGFloat webviewHeight = self.frame.size.height;
    CGFloat contentHeight = [[self stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    
    NSString *js = @"window.scrollTo(0,0)";
    [self stringByEvaluatingJavaScriptFromString:js];
    
    NSLog(@"screenshot...");
    NSMutableArray *imageItems = [NSMutableArray array];
    float offset = 0;
    while (offset < contentHeight) {
        
        js = [NSString stringWithFormat:@"window.scrollTo(0,%f)",offset];
        [self stringByEvaluatingJavaScriptFromString:js];
        
        @autoreleasepool {
            
            
            
            
        }
        
    }
    
    NSLog(@"rendering...");
    UIGraphicsBeginImageContextWithOptions(CGSizeZero, NO, 0);
    for(id item in imageItems){
        @autoreleasepool {
            
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}


@end
