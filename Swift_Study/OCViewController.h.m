//
//  OC1ViewController.m
//  Swift_Study
//
//  Created by james on 2022/2/14.
//

#import "OCViewController.h"
#import "Swift_Study-Swift.h"

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    tipLab.text = @"OC与Swift混编";
    tipLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLab];
    
    SLabel *sLabel = [[SLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tipLab.frame), self.view.frame.size.width, 50)];
    [sLabel setDefaultTextWithText:@"在OC类中调用Swift类方法"];
    [self.view addSubview:sLabel];
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
