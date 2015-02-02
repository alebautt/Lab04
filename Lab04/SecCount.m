//
//  ViewController.m
//  Lab04
//
//  Created by Alejandra B on 01/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import "SecCount.h"
#import "VarGlobal.h"

@interface SecCount ()

@end

NSInteger intClicCount=0;
NSInteger intSecCount=0;
NSTimer *timer;

@implementation SecCount

- (void)viewDidLoad {
    
    intClicCount=0;
    intSecCount=0;
    self.btnCount.enabled=false;
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnStart:(id)sender {
    self.btnCount.enabled=true;
    
    [timer invalidate];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(MyCountSeconds)userInfo:nil repeats:YES];
}

- (IBAction)btnCount:(id)sender {
    intClicCount++;
    self.lblResult.text = [NSString stringWithFormat: @"%ld", intClicCount];
}


-(void)MyCountSeconds{
    
    intSecCount++;
    self.lblStart.text = [NSString
                          stringWithFormat: @"%ld",  intSecCount];
    
    if(intSecCount==10)
    {
        [timer invalidate];
             //extrae la fecha actual
        //..  NSDate *today = [NSDate date];
        //.. NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init ];
        //..[dateFormat setDateFormat:@"dd/MM/yyy"];
        //.. NSString *dateString = [dateFormat stringFromDate:today];
        
        //Agrega el total de clicks
        [self Save];
        
        
        //Terminando los 10 segundos pasa automaticamente a la siguiente pantalla de resultados
       [self performSegueWithIdentifier:@"SegueTable" sender:self];
    }
}


-(void)Save{
    BOOL success = NO;
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    success = [[classBD getSharedInstance]
               saveData:[NSString stringWithFormat:@"%li",(long)intClicCount]
               detail:[DateFormatter stringFromDate:[NSDate date]]];
}


@end
