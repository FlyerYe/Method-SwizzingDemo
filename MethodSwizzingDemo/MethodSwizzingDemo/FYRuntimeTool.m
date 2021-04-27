//
//  FYRuntimeTool.m
//  MethodSwizzingDemo
//
//  Created by FuYe on 2021/4/27.
//

#import "FYRuntimeTool.h"
#import <objc/runtime.h>
@implementation FYRuntimeTool

+(void)simple_methodSwizzingWithClass:(Class)cls oriSEL: (SEL)oriSEL SwizzledSEL: (SEL)swizzledSEL
{
    if (!cls) NSLog(@"Class is nil");
    //原始方法
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    //新方法
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
    //交换imp
    method_exchangeImplementations(oriMethod, swiMethod);
}

+(void)better_methodSwizzingWithClass:(Class)cls oriSEL: (SEL)oriSEL SwizzledSEL: (SEL)swizzledSEL
{
   
    if (!cls) NSLog(@"Class is nil");
    //原始方法
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    //新方法
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
    //针对父类中没有实现交换方法,那么我们尝试放父类添加一个swizzledSEL的实现
    BOOL didAddMethod = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    if (didAddMethod) {
        //添加成功,代替替换方法的实现
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        //未添加成功，说明类中已存在
        method_exchangeImplementations(oriMethod, swiMethod);
    }
}

+(void)safe_methodSwizzingWithClass:(Class)cls oriSEL: (SEL)oriSEL SwizzledSEL: (SEL)swizzledSEL {
    if (!cls) NSLog(@"Class is nil");
    //原始方法
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    //新方法
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
   
    //如果原始方法没有实现，来个默认实现，避免交换了个寂寞
    if (!oriMethod) {
        //oriMethod为nil时，oriSEL添加了 swiMethod 的imp，替换后将swizzledSEL添加一个不做任何事的空实现imp
        class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        method_setImplementation(swiMethod, imp_implementationWithBlock(^(id self, SEL _cmd){
            NSLog(@"%@方法没有实现！！！,添加了默认实现IMP",self);
        }));
    } else {
        //针对父类中没有实现交换方法,那么我们尝试放父类添加一个swizzledSEL的实现
        BOOL didAddMethod = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        if (didAddMethod) {
            //添加成功,代替替换方法的实现
            class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        } else {
            //未添加成功，说明类中已存在
            method_exchangeImplementations(oriMethod, swiMethod);
        }
    }
    
  
}


@end
