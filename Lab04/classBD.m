//
//  classBD.m
//  Lab04
//
//  Created by Alejandra B on 01/02/15.
//  Copyright (c) 2015 alebautista. All rights reserved.
//

#import "classBD.h"

static NSString    *DBFile = @"pushCounter.db";
static const char  *CreateTable  = "create table if not exists scores (id integer primary key autoincrement, score integer, detail text)";
static NSString    *insertScores = @"insert into scores (score,detail) values (\"%ld\",\"%@\")";
static classBD *sharedInstance = nil;
static sqlite3         *database = nil;
static sqlite3_stmt   *statement = nil;


@implementation classBD
+(classBD*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

//craate my data base
-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    DBpath = [[NSString alloc] initWithString:
    [docsDir stringByAppendingPathComponent: DBFile ]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: DBpath ] == NO)
    {
        const char *dbpath = [DBpath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = CreateTable;
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table %s",errMsg);
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

//save date
- (BOOL) saveData:(NSString*)registerNumber detail:(NSString*)detail;
{
    const char *dbpath = [DBpath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:insertScores,(long)[registerNumber integerValue], detail];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_reset(statement);
            score = [registerNumber intValue];
            NSLog(@"Se ha guardado");
            return YES;
            
        } else {
            NSLog(@"Statement FAILED (%s)", sqlite3_errmsg(database));
            sqlite3_reset(statement);
            return NO;
        }
    }
    return NO;
}

- (NSArray*) findByRegisterNumber:(NSString*)registerNumber
{
    const char *dbpath = [DBpath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"select score, detail from scores where id=\"%@\"",registerNumber];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *score = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:score];
                NSString *detail = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:detail];
                sqlite3_reset(statement);
                return resultArray;
            } else {
                NSLog(@"Not found");
                sqlite3_reset(statement);
                return nil;
            }
        }
    }
    return nil;
}

-(NSArray*) allRecords{
    const char *dbpath = [DBpath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"select score, detail from scores order by score desc"];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *score = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
                //[resultArray addObject:score];
                NSString *detail = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1)];
                //[resultArray addObject:detail];
                [resultArray addObject:[NSMutableArray arrayWithObjects: detail, score, nil]];
            }
            sqlite3_reset(statement);
            return resultArray;
        }
    }
    return nil;
}
@end
