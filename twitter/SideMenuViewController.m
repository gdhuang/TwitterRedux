//
//  SideMenuViewController.m
//  twitter
//
//  Created by GD Huang on 7/5/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import "SideMenuViewController.h"

@interface SideMenuViewController ()


@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *sideMenuPanGesture;

@property (strong, nonatomic) UIViewController* menuViewController;
@property (strong, nonatomic) UIViewController* contentViewController;

@end

@implementation SideMenuViewController



- (id)initWithMenuViewController:(UIViewController *)mvc contentViewController:(UIViewController *)cvc {
    self = [super init];
    
    self.menuViewController = mvc;
    self.contentViewController = cvc;
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.menuViewController.view.frame = self.menuView.frame;
    [self.menuView addSubview:self.menuViewController.view];
    
    self.contentViewController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.contentViewController.view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onPan:(id)sender {
    CGPoint point = [self.sideMenuPanGesture locationInView:self.view];
    static CGFloat offset;
    
    if (self.sideMenuPanGesture.state == UIGestureRecognizerStateBegan) {
        offset = self.contentView.center.x - [self.sideMenuPanGesture locationInView:self.view].x;
    } else if (self.sideMenuPanGesture.state == UIGestureRecognizerStateChanged) {
        self.contentView.center = CGPointMake(point.x + offset, self.contentView.center.y);
    } else if (self.sideMenuPanGesture.state == UIGestureRecognizerStateEnded) {
        CGRect contentFrame = self.contentView.frame;
        CGSize contentSize = contentFrame.size;
        if ([self.sideMenuPanGesture velocityInView:self.view].x > 0) {
            [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.contentView.frame = CGRectMake(self.view.frame.size.width-50, 0, contentSize.width, contentSize.height);
            } completion:^(BOOL finished) {
            }];
        } else {
            [UIView animateWithDuration:0.2 animations:^{
                self.contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
        
    }
    
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
