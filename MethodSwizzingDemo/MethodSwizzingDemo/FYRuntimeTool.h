//
//  FYRuntimeTool.h
//  MethodSwizzingDemo
//
//  Created by FuYe on 2021/4/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYRuntimeTool : NSObject

+(void)simple_methodSwizzingWithClass:(Class)cls oriSEL: (SEL)oriSEL SwizzledSEL: (SEL)swizzledSEL;

+(void)better_methodSwizzingWithClass:(Class)cls oriSEL: (SEL)oriSEL SwizzledSEL: (SEL)swizzledSEL;

+(void)safe_methodSwizzingWithClass:(Class)cls oriSEL: (SEL)oriSEL SwizzledSEL: (SEL)swizzledSEL;

@end

NS_ASSUME_NONNULL_END
