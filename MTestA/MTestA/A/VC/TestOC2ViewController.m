//
//  TestOC2ViewController.m
//  TestA
//
//  Created by 董雪娇 on 2020/3/6.
//  Copyright © 2020 董雪娇. All rights reserved.
//

#import "TestOC2ViewController.h"

@interface TestOC2ViewController ()

@end

@implementation TestOC2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor brownColor];
    
    self.navigationItem.title = NSStringFromClass(self.class);

    //[BasisTool toolMethods:@"TestC"];//TestC没有集成BasisTool
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"TestOC2ViewController" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 300, 200, 50);
    [btn addTarget:self action:@selector(btn_Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btn_Action{
    if (self.test2CompleteHandler) {
        self.test2CompleteHandler(@"OC2-block");
    }
    [self.navigationController popViewControllerAnimated:true];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
