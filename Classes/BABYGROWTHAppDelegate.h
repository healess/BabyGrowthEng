//
//  BABYGROWTHAppDelegate.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO on 11. 10. 23..
//  Copyright 2011 POSCO ICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BABYGROWTHAppDelegate : NSObject <UIApplicationDelegate, UIAlertViewDelegate> 
{
    
    UIWindow *window;
    UINavigationController *navigationController;
	
	NSString *DBName;//DB지정
	NSString *DBPath;//DB경로
	NSMutableArray *DBData;//DB값
	
	UIImage *capturedImage;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) NSString *DBName;
@property (nonatomic, retain) NSString *DBPath;
@property (nonatomic, retain) NSMutableArray *DBData;
@property (assign) BOOL isFirstTimeAccess;

@property (nonatomic, retain) UIImage *capturedImage;

-(void) checkAndCreateDatabase;//DB 커넥션 생성
//-(void) readDataFromDatabase;//SQL수행
-(void) readDataFromDatabase:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight Weight:(NSString*)pWeight Length:(NSString*)pLength;
-(void) calculateHeightFromDatabase:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight;
-(void) calculateHeightPercentFromDatabase:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth HeightPercent:(NSString*)pHeightPercent;
-(void) calculateBMIFromDatabase:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth BMI:(NSString*)pBMI;
-(void) saveHistoryToDatabase:(NSString*)inputName Gender:(NSString*)inputGender Date:(NSString*)inputDate Year:(NSString*)inputYear Month:(NSString*)inputMonth Height:(NSString*)inputHeight HeightPercent:(NSString*)inputHeightPercent Weight:(NSString*)inputWeight WeightPercent:(NSString*)inputWeightPercent Length:(NSString*)inputLength LengthPercent:(NSString*)inputLengthPercent;
-(void) retrieveHistoryFromDatabase:(NSString*)inputName;
-(void) deleteHistoryToDatabase:(NSString*)inputIndex;
-(void) retrieveChildNameFromDatabase;
-(void) ShowMessageBoxRequireReview;
-(NSString*)dateInFormat:(NSString*)stringFormat; //날짜관련..

@end

