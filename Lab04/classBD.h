//
//  classBD.h
//  Lab04
//
//  Created by Alejandra B on 01/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
int score;

@interface classBD : NSObject
{
    NSString *DBpath;
}

+(classBD*)getSharedInstance;
-(BOOL)createDB;
-(BOOL)saveData:(NSString*)registerNumber detail:(NSString*)
detail;
-(NSArray*) findByRegisterNumber:(NSString*)registerNumber;
-(NSArray*) allRecords;

@end
