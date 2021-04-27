//
//  FYStudent+FY.m
//  MethodSwizzingDemo
//
//  Created by FuYe on 2021/4/27.
//

#import "FYStudent+FY.h"
#import "FYRuntimeTool.h"
@implementation FYStudent (FY)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [FYRuntimeTool safe_methodSwizzingWithClass:self oriSEL:@selector(study) SwizzledSEL:@selector(newInstanceMethod)];
    });
}

//交换方法
- (void)newInstanceMethod {
    NSLog(@"FYStudent分类添加方法:%s",__func__);
    [self newInstanceMethod];
}

@end
