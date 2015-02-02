//
//  ViewController.h
//  Lab04
//
//  Created by Alejandra B on 01/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classBD.h"

@interface SecCount : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblResult;
@property (strong, nonatomic) IBOutlet UIButton *btnCount;

@property (strong, nonatomic) IBOutlet UIButton *btnStart;
@property (strong, nonatomic) IBOutlet UILabel *lblStart;

@end

