//
//  ViewController.m
//  MethodSwizzingDemo
//
//  Created by FuYe on 2021/4/27.
//

#import "ViewController.h"
#import "FYStudent+FY.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //子类的分类中方法交换，子类没有eatFood实现，父类中实现
//    FYStudent *student = [FYStudent alloc];
//    [student eatFood];
    
    //崩溃，当eatFood方法调用时，父类 eatFood找交换的imp,但是父类中并没有newInstanceMethod的imp;
    FYPerson *person = [FYPerson alloc];
    [person eatFood];
    
//    FYStudent *student = [FYStudent alloc];
//    [student study];
    
}


@end
