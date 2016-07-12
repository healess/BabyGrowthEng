//
//  BABYGROWTHAppDelegate.m
//  BABYGROWTH
//
//  Created by JUNG BUM SEO on 11. 10. 23..
//  Copyright 2011 POSCO ICT. All rights reserved.
//

#import "BABYGROWTHAppDelegate.h"
#import "GrowthAnalizeViewController.h"
#import "InfantData.h"

@implementation BABYGROWTHAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize DBName;
@synthesize DBPath;
@synthesize DBData;
@synthesize isFirstTimeAccess;
@synthesize capturedImage;

#pragma mark -
#pragma mark Application lifecycle

//===============================================================================================
// 날짜관련...
//===============================================================================================
-(NSString*)dateInFormat:(NSString*) stringFormat
{
	char buffer[80];
	const char *format=[stringFormat UTF8String];
	time_t rawtime;
	struct tm *timeinfo;
	time(&rawtime);
	timeinfo=localtime(&rawtime);
	strftime(buffer,80,format,timeinfo);
	return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

//============================================================================================================
// 기본값 설정 및 기억준비 2012.3.4  (initialize 는 NSObject 의 클래스 매소드로서 오브젝트 사용전 호출되는 메소드임)
//============================================================================================================
+(void) initialize
{
	if([self class]==[BABYGROWTHAppDelegate class])
	{
		
		//성장진단기본값
		NSString *defaultGrowAnalizeGender		=@"";
		NSString *defaultGrowAnalizeBirthYear	=@"";
		NSString *defaultGrowAnalizeBirthMonth	=@"";
		NSString *defaultGrowAnalizeBirthDay	=@"";
		NSString *defaultGrowAnalizeHeight		=@"";
		NSString *defaultGrowAnalizeWegiht		=@"";
		NSString *defaultGrowAnalizeLength		=@"";
		NSString *defaultGrowAnalizeHeightUnit	=@""; //키 단위저장(글로벌버전용 2012.10.14 추가)
		NSString *defaultGrowAnalizeWegihtUnit	=@""; //몸무게 단위저장(글로벌버전용 2012.10.14 추가)
		NSString *defaultGrowAnalizeLengthUnit	=@""; //머리둘레 단위저장(글로벌버전용 2012.10.14 추가)
		
		//신장예측기본값
		NSString *defaultGrowEstimateGender				=@"";
		NSString *defaultGrowEstimateBirthYear			=@"";
		NSString *defaultGrowEstimateBirthMonth			=@"";
		NSString *defaultGrowEstimateHeight				=@"";
		NSString *defaultGrowEstimateFatherHeight		=@"";
		NSString *defaultGrowEstimateMotherHeight		=@"";
		NSString *defaultGrowEstimateHeightUnit			=@""; //키 단위저장(글로벌버전용 2012.10.14 추가)
		NSString *defaultGrowEstimateFatherHeightUnit	=@""; //아빠키 단위저장(글로벌버전용 2012.10.14 추가)
		NSString *defaultGrowEstimateMotherHeightUnit	=@""; //엄마키 단위저장(글로벌버전용 2012.10.14 추가)
		
		//비만측정기본값
		NSString *defaultGrowBMIGender			=@"";
		NSString *defaultGrowBMIBirthYear		=@"";
		NSString *defaultGrowBMIBirthMonth		=@"";
		NSString *defaultGrowBMIHeight			=@"";
		NSString *defaultGrowBMIWegiht			=@"";
		NSString *defaultGrowBMIHeightUnit		=@"";	//키 단위저장(글로벌버전용 2012.10.14 추가)
		NSString *defaultGrowBMIWegihtUnit		=@"";	//몸무게 단위저장(글로벌버전용 2012.10.14 추가)
		
		
		//이력저장시 이름 기본값 (2012.3.25 추가 by 서정범)
		NSString *defaultBabyName			=@"";		
		
		
		//리뷰써달라고 조르는것들 관련 
		NSString *defaultAtLeastOneUse				=@"NO";		//한번이라도 끝까지 실행해 봤는지.
		NSString *defaultNoMoreRecommendWriteReview	=@"NO";		//리뷰등록을 더이상 보지않는다고 했는지		
		NSString * defaultNextRequestReviewDate		=@"19760618";//리뷰를 안썼다면 다시 써달라고 이야기할 다음 날짜
		
		
		
		
		
		
		//옵션의 키와 값들을 담는 NSDictionary를 생성
		NSDictionary *dicOptionDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
										   
										   defaultGrowAnalizeGender,			@"keyGrowAnalizeGender",
										   defaultGrowAnalizeBirthYear,			@"keyGrowAnalizeBirthYear",
										   defaultGrowAnalizeBirthMonth,		@"keyGrowAnalizeBirthMonth",
										   defaultGrowAnalizeBirthDay,			@"keyGrowAnalizeBirthDay",
										   defaultGrowAnalizeHeight,			@"keyGrowAnalizeHeight",
										   defaultGrowAnalizeWegiht,			@"keyGrowAnalizeWegiht",
										   defaultGrowAnalizeLength,			@"keyGrowAnalizeLength",
										   defaultGrowAnalizeHeightUnit,		@"keyGrowAnalizeHeightUnit",
										   defaultGrowAnalizeWegihtUnit,		@"keyGrowAnalizeWegihtUnit",
										   defaultGrowAnalizeLengthUnit,		@"keyGrowAnalizeLengthUnit",
										   
										   defaultGrowEstimateGender,			@"keyGrowEstimateGender",
										   defaultGrowEstimateBirthYear,		@"keyGrowEstimateBirthYear",
										   defaultGrowEstimateBirthMonth,		@"keyGrowEstimateBirthMonth",
										   defaultGrowEstimateHeight,			@"keyGrowEstimateHeight",
										   defaultGrowEstimateFatherHeight,		@"keyGrowEstimateFatherHeight",
										   defaultGrowEstimateMotherHeight,		@"keyGrowEstimateMotherHeight",
										   defaultGrowEstimateHeightUnit,		@"keyGrowEstimateHeightUnit",
										   defaultGrowEstimateFatherHeightUnit,	@"keyGrowEstimateFatherHeightUnit",
										   defaultGrowEstimateMotherHeightUnit,	@"keyGrowEstimateMotherHeightUnit",
										   
										   defaultGrowBMIGender,				@"keyGrowBMIGender",
										   defaultGrowBMIBirthYear,				@"keyGrowBMIBirthYear",
										   defaultGrowBMIBirthMonth,			@"keyGrowBMIBirthMonth",
										   defaultGrowBMIHeight,				@"keyGrowBMIHeight",
										   defaultGrowBMIWegiht,				@"keyGrowBMIWegiht",
										   defaultGrowBMIHeightUnit,			@"keyGrowBMIHeightUnit",
										   defaultGrowBMIWegihtUnit,			@"keyGrowBMIWegihtUnit",
										   
										   defaultBabyName,						@"keyBabyName",										   
										   
										   defaultAtLeastOneUse,				@"keyAtLeastOneUse",											   
										   defaultNoMoreRecommendWriteReview,	@"keyNoMoreRecommendWriteReview",
										   
										   defaultNextRequestReviewDate,		@"keyNextRequestReviewDate",
										   nil];
		
		//사용자가 앱을 설치하고 처음 실행항 때 적용하는 옵션값 등록 (dictionary 정보 이용)
		[[NSUserDefaults standardUserDefaults] registerDefaults:dicOptionDefaults];
	}
}

//============================================================================================================
// 리뷰써달라는 메세지 박스
//============================================================================================================
-(void) ShowMessageBoxRequireReview
{	
	
	
	//리뷰창
	NSString *temp	=[[NSUserDefaults standardUserDefaults] stringForKey:@"keyAtLeastOneUse"];
	NSString *temp2	=[[NSUserDefaults standardUserDefaults] stringForKey:@"keyNoMoreRecommendWriteReview"];
	NSString *tempdate	=[[NSUserDefaults standardUserDefaults] stringForKey:@"keyNextRequestReviewDate"];	
	
	
	//나중에 남기기를 한지 3일이 지났다면 리뷰써달라고 리뷰써달라고 요청하는  창 띄움		
	int valueInterval;
	int valueOfToday, valueofNextRequestReviewDate;
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
	NSString *currentLanguage = [languages objectAtIndex:0];
	NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
	[formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:currentLanguage] autorelease]];
	[formatter setDateFormat:@"yyyyMMdd"];	
	
	
	//디폴트에 저장된 날짜	
	valueofNextRequestReviewDate=[tempdate intValue];		
	
	//오늘날짜
	NSDate *now = [NSDate date];
	valueOfToday = [[formatter stringFromDate:now] intValue]; 
	
	//두 날짜 차이	
	valueInterval = valueOfToday - valueofNextRequestReviewDate; 	
	
	
	NSLog(@"오늘날짜:%d",valueOfToday);
	NSLog(@"마지막실행날짜:%d",valueofNextRequestReviewDate);
	NSLog(@"최소한번은측정했나:%@",temp);
	NSLog(@"다시보지않기를눌렀나:%@",temp2);
	
	
	
	//최소한번은 측정했고 더이상보지않기를 누른적 없으며 나중에 남기기 한후 1일이상 지났다면 리뷰써달라고 요청하는  창 띄움
	/*아래내용은 URL 이 발급된 이후에 
	if([temp isEqualToString:@"YES"]&&[temp2 isEqualToString:@"NO"]&&valueInterval>=1)
	{
		
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"BabyGrowth"
														  message:@"Thank you for first using Growth diagnostics App.\n When you leave the review, app will be better."//성장진단 어플 첫 사용 감사합니다.\n 리뷰를 남겨주시면 앱을 더 알차게 꾸미는데 도움이 됩니다. 리뷰를 남겨주세요.
														 delegate:self
												cancelButtonTitle:@"Don't see the message." //다시보지않기
												otherButtonTitles:@"Enter the review", @"Leave the review later.", nil]; //리뷰남기러가기, 나중에 남기기
		[message show];
		
	}
	*/
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{ 
	switch(buttonIndex) 
	{
		case 0:
			NSLog(@"다시보지않기 누름");			
			[[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"keyNoMoreRecommendWriteReview"];
			break;
		case 1:
			NSLog(@"리뷰남기러가기 누름");
			[[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"keyNoMoreRecommendWriteReview"];
			NSURL *url = [[NSURL alloc] initWithString: @"http://itunes.apple.com/kr/app/seongjangjindan/id501316252?ls=1&mt=8"];
			[[UIApplication sharedApplication] openURL:url];
			break;
		case 2:
			NSLog(@"나중에 남기기 누름");		
			//현재날짜를 계산하여 디폴트 값에 넣는다.
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
			NSString *currentLanguage = [languages objectAtIndex:0];
			NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
			[formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:currentLanguage] autorelease]];
			[formatter setDateFormat:@"yyyyMMdd"];	
			NSDate *now = [NSDate date];			
			[[NSUserDefaults standardUserDefaults] setObject:[formatter stringFromDate:now] forKey:@"keyNextRequestReviewDate"];
			
			break;
		default:
			break;
	}	 
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    //초기화면 딜레이(3초)
	[NSThread sleepForTimeInterval:1];
	
	// Override point for customization after application launch.
	self.isFirstTimeAccess = TRUE;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];//디렉토리 경로
	self.DBName = @"infantDB.db";
	self.DBPath = [documentsDir stringByAppendingPathComponent:self.DBName];//경로 담기
	//NSLog(@" %@ ",self.DBPath);
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
	[self checkAndCreateDatabase];
    return YES;
	
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

//DB접속
-(void) checkAndCreateDatabase
{
	
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem	
	// If the database already exists then return without doing anything
	if([fileManager fileExistsAtPath:self.DBPath]) 
	{
		return;
	}
	else 
	{
		NSString *databasePathFromApp = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:self.DBName];
		
		// Copy the database from the package to the users filesystem	
		[fileManager copyItemAtPath:databasePathFromApp toPath:self.DBPath error:nil];
		[fileManager release];
	}
}

//SQL수행 부분 입력값은 View에서 받은 값
-(void) readDataFromDatabase:(NSString*)inputGender Year:(NSString*)inputYear Month:(NSString*)inputMonth Height:(NSString*)inputHeight Weight:(NSString*)inputWeight Length:(NSString*)inputLength{
	
	sqlite3 *database;
	
	// Init the DBData Array
	if(self.isFirstTimeAccess == TRUE)
	{
		self.DBData = [[NSMutableArray alloc] init];
		self.isFirstTimeAccess = FALSE;
	}
	else
	{
		[self.DBData removeAllObjects];
	}
	
	// Open the database from the users filessytem
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		//	const char *sqlStatement = "SELECT MP_Index,MP_Percent FROM tblInfantGrowth Where MP_Country='K' and MP_Type='H' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value=? union all SELECT MP_Index,MP_Percent FROM tblInfantGrowth Where MP_Country='K' and MP_Type='W' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value=? union all SELECT MP_Index,MP_Percent FROM tblInfantGrowth Where MP_Country='K' and MP_Type='L' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value=?";
		const char *sqlStatement = "SELECT  A.MP_Index,round(A.MP_Percent+ (?-A.MP_Value)/((B.MP_Value-A.MP_Value) / (B.MP_Percent-A.MP_Percent)),0) as MP_Percent FROM(SELECT MP_Index,max(MP_Percent) as MP_Percent,MP_Value ,MP_Type FROM Tb_Infant_Growth Where MP_Country='W' and MP_Type='H' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value<=? ) A, (SELECT MP_Index,min(MP_Percent) as MP_Percent ,MP_Value ,MP_Type FROM Tb_Infant_Growth Where MP_Country='W' and MP_Type='H' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value>? ) B union all SELECT  A.MP_Index,round(A.MP_Percent+ (?-A.MP_Value)/((B.MP_Value-A.MP_Value) / (B.MP_Percent-A.MP_Percent)),0) as MP_Percent FROM  (SELECT MP_Index,max(MP_Percent) as MP_Percent,MP_Value ,MP_Type FROM Tb_Infant_Growth Where MP_Country='W' and MP_Type='W' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value<=? ) A, (SELECT MP_Index,min(MP_Percent) as MP_Percent ,MP_Value ,MP_Type FROM Tb_Infant_Growth Where MP_Country='W' and MP_Type='W' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value>? ) B union all SELECT  A.MP_Index,round(A.MP_Percent+ (?-A.MP_Value)/((B.MP_Value-A.MP_Value) / (B.MP_Percent-A.MP_Percent)),0) as MP_Percent FROM  (SELECT MP_Index,max(MP_Percent) as MP_Percent,MP_Value ,MP_Type FROM Tb_Infant_Growth Where MP_Country='K' and MP_Type='L' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value<=? ) A, (SELECT MP_Index,min(MP_Percent) as MP_Percent ,MP_Value ,MP_Type FROM Tb_Infant_Growth Where MP_Country='K' and MP_Type='L' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value>? ) B";
		
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_text(compiledStatement, 1, [inputHeight UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 2, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 3, [inputYear UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 4, [inputMonth UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 5, [inputHeight UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 6, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 7, [inputYear UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 8, [inputMonth UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 9, [inputHeight UTF8String],  -1, SQLITE_TRANSIENT);
			
			sqlite3_bind_text(compiledStatement, 10, [inputWeight UTF8String],  -1, SQLITE_TRANSIENT);			
			sqlite3_bind_text(compiledStatement, 11, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 12, [inputYear UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 13, [inputMonth UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 14, [inputWeight UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 15, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 16, [inputYear UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 17, [inputMonth UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 18, [inputWeight UTF8String],  -1, SQLITE_TRANSIENT);
			
			sqlite3_bind_text(compiledStatement, 19, [inputLength UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 20, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 21, [inputYear UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 22, [inputMonth UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 23, [inputLength UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 24, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 25, [inputYear UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 26, [inputMonth UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 27, [inputLength UTF8String],  -1, SQLITE_TRANSIENT);
			NSLog(@"Check Log");
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *aPercent ;
				NSInteger aIndex = sqlite3_column_int(compiledStatement, 0);//인덱스 값
				if(sqlite3_column_text(compiledStatement, 1)==nil){
					aPercent=@"표준범위초과";
				}else{
					aPercent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];//백분위수 값
					int aPercent2=[aPercent intValue];
					aPercent=[[NSString alloc] initWithFormat:@"%i", aPercent2];
				}
				NSLog(@" %@ ",aPercent);
				
				InfantData *md = [[InfantData alloc] initWithData:aIndex Percent:aPercent];
				
				// Add the BatteryInsightDB object to the DBData Array
				[self.DBData addObject:md];
				
				[md release];
			}
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
}

//SQL수행 부분 입력값은 View에서 받은 값
-(void) calculateHeightFromDatabase:(NSString*)inputGender Year:(NSString*)inputYear Month:(NSString*)inputMonth Height:(NSString*)inputHeight{
	
	sqlite3 *database;
	
	// Init the DBData Array
	if(self.isFirstTimeAccess == TRUE)
	{
		self.DBData = [[NSMutableArray alloc] init];
		self.isFirstTimeAccess = FALSE;
	}
	else
	{
		[self.DBData removeAllObjects];
	}
	
	// Open the database from the users filessytem
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT  A.MP_Index,round(A.MP_Percent+ (?-A.MP_Value)/((B.MP_Value-A.MP_Value) / (B.MP_Percent-A.MP_Percent)),0) as MP_Percent FROM(SELECT MP_Index,max(MP_Percent) as MP_Percent,MP_Value ,MP_Type FROM Tb_Infant_Growth Where MP_Country='W' and MP_Type='H' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value<=? ) A, (SELECT MP_Index,min(MP_Percent) as MP_Percent ,MP_Value ,MP_Type FROM Tb_Infant_Growth Where MP_Country='W' and MP_Type='H' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value>? ) B";
		
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_text(compiledStatement, 1, [inputHeight UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 2, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 3, [inputYear UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 4, [inputMonth UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 5, [inputHeight UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 6, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 7, [inputYear UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 8, [inputMonth UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 9, [inputHeight UTF8String],  -1, SQLITE_TRANSIENT);
			
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *aPercent ;
				NSInteger aIndex = sqlite3_column_int(compiledStatement, 0);//인덱스 값
				if(sqlite3_column_text(compiledStatement, 1)==nil){
					aPercent=@"표준범위초과";
				}else{
					aPercent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];//백분위수 값
					int aPercent2=[aPercent intValue];
					aPercent=[[NSString alloc] initWithFormat:@"%i", aPercent2];
				}
				NSLog(@" %@ ",aPercent);
				
				InfantData *md = [[InfantData alloc] initWithData:aIndex Percent:aPercent];
				
				// Add the BatteryInsightDB object to the DBData Array
				[self.DBData addObject:md];
				
				[md release];
			}
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
}

//SQL수행 부분 입력값은 View에서 받은 값
-(void) calculateHeightPercentFromDatabase:(NSString*)inputGender Year:(NSString*)inputYear Month:(NSString*)inputMonth HeightPercent:(NSString*)inputHeightPercent{
	
	sqlite3 *database;
	
	// Init the DBData Array
	if(self.isFirstTimeAccess == TRUE)
	{
		self.DBData = [[NSMutableArray alloc] init];
		self.isFirstTimeAccess = FALSE;
	}
	else
	{
		[self.DBData removeAllObjects];
	}
	
	// Open the database from the users filessytem
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT  A.MP_Index,round(A.MP_Value + (?-A.MP_Percent)/((B.MP_Percent-A.MP_Percent) / (B.MP_Value-A.MP_Value)),0) as MP_Value FROM(SELECT MP_Index,max(MP_Value) as MP_Value,MP_Percent ,MP_Type FROM Tb_Infant_Growth Where MP_Country='W' and MP_Type='H' and MP_Gender=? and MP_Year='18' and MP_Month='12' and MP_Percent<=? ) A, (SELECT MP_Index,min(MP_Value) as MP_Value ,MP_Percent ,MP_Type FROM Tb_Infant_Growth Where MP_Country='W' and MP_Type='H' and MP_Gender=? and MP_Year='18' and MP_Month='12' and MP_Percent>? ) B ";
		
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_text(compiledStatement, 1, [inputHeightPercent UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 2, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 3, [inputHeightPercent UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 4, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 5, [inputHeightPercent UTF8String],  -1, SQLITE_TRANSIENT);
			
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *aPercent ;
				NSInteger aIndex = sqlite3_column_int(compiledStatement, 0);//인덱스 값
				if(sqlite3_column_text(compiledStatement, 1)==nil){
					aPercent=@"표준범위초과";
				}else{
					aPercent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];//백분위수 값
					int aPercent2=[aPercent intValue];
					aPercent=[[NSString alloc] initWithFormat:@"%i", aPercent2];
				}
				//NSLog(@" %@ ",aPercent);
				
				InfantData *md = [[InfantData alloc] initWithData:aIndex Percent:aPercent];
				
				// Add the BatteryInsightDB object to the DBData Array
				[self.DBData addObject:md];
				
				[md release];
			}
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
}

//SQL수행 부분 입력값은 View에서 받은 값
-(void) calculateBMIFromDatabase:(NSString*)inputGender Year:(NSString*)inputYear Month:(NSString*)inputMonth BMI:(NSString*)inputBMIValue{
	
	sqlite3 *database;
	
	// Init the DBData Array
	if(self.isFirstTimeAccess == TRUE)
	{
		self.DBData = [[NSMutableArray alloc] init];
		self.isFirstTimeAccess = FALSE;
	}
	else
	{
		[self.DBData removeAllObjects];
	}
	// Open the database from the users filessytem
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT  A.MP_Index,round(A.MP_Percent+ (?-A.MP_Value)/((B.MP_Value-A.MP_Value) / (B.MP_Percent-A.MP_Percent)),0) as MP_Percent FROM(SELECT MP_Index,max(MP_Percent) as MP_Percent,MP_Value ,MP_Type FROM Tb_Infant_Growth Where MP_Country='W' and MP_Type='B' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value<=? ) A, (SELECT MP_Index,min(MP_Percent) as MP_Percent ,MP_Value ,MP_Type FROM Tb_Infant_Growth Where MP_Country='W' and MP_Type='B' and MP_Gender=? and MP_Year=? and MP_Month=? and MP_Value>? ) B";
		
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_text(compiledStatement, 1, [inputBMIValue UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 2, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 3, [inputYear UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 4, [inputMonth UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 5, [inputBMIValue UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 6, [inputGender UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 7, [inputYear UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 8, [inputMonth UTF8String],  -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 9, [inputBMIValue UTF8String],  -1, SQLITE_TRANSIENT);
			
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *aPercent ;
				NSInteger aIndex = sqlite3_column_int(compiledStatement, 0);//인덱스 값
				if(sqlite3_column_text(compiledStatement, 1)==nil){
					aPercent=@"표준범위초과";
				}else{
					aPercent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];//백분위수 값
					int aPercent2=[aPercent intValue];
					aPercent=[[NSString alloc] initWithFormat:@"%i", aPercent2];
				}
				//NSLog(@" %@ ",aPercent);
				
				InfantData *md = [[InfantData alloc] initWithData:aIndex Percent:aPercent];
				
				// Add the BatteryInsightDB object to the DBData Array
				[self.DBData addObject:md];
				
				[md release];
			}
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
}

//이력저장
-(void) saveHistoryToDatabase:(NSString*)inputName Gender:(NSString*)inputGender Date:(NSString*)inputDate Year:(NSString*)inputYear Month:(NSString*)inputMonth Height:(NSString*)inputHeight HeightPercent:(NSString*)inputHeightPercent Weight:(NSString*)inputWeight WeightPercent:(NSString*)inputWeightPercent Length:(NSString*)inputLength LengthPercent:(NSString*)inputLengthPercent{
	
	sqlite3 *database;
	// Init the DBData Array
	if(self.isFirstTimeAccess == TRUE)
	{
		self.DBData = [[NSMutableArray alloc] init];
		self.isFirstTimeAccess = FALSE;
	}
	else
	{
		[self.DBData removeAllObjects];
	}
	
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		//INSERT INTO tblMemoPad(MP_Title, MP_Content, MP_Date) VALUES('Sample data 1','Hello! This is a sample content 1','2010-01-01 00:00:00');
		
		const char *sqlStatement = "INSERT INTO Tb_Growth_History(Child_Name ,Gender ,Current_Date ,Birth_Year ,Birth_Month ,Height_Value ,Height_Percent ,Weight_Value ,Weight_Percent ,Leight_Value ,Leight_Percent ) VALUES(?,?,?,?,?,?,?,?,?,?,?);";
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			sqlite3_bind_text(compiledStatement, 1, [inputName UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 2, [inputGender UTF8String] , -1, SQLITE_TRANSIENT);  
			sqlite3_bind_text(compiledStatement, 3, [inputDate UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 4, [inputYear UTF8String] , -1, SQLITE_TRANSIENT); 
			sqlite3_bind_text(compiledStatement, 5, [inputMonth UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 6, [inputHeight UTF8String] , -1, SQLITE_TRANSIENT); 
			sqlite3_bind_text(compiledStatement, 7, [inputHeightPercent UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 8, [inputWeight UTF8String] , -1, SQLITE_TRANSIENT); 
			sqlite3_bind_text(compiledStatement, 9, [inputWeightPercent UTF8String] , -1, SQLITE_TRANSIENT); 
			sqlite3_bind_text(compiledStatement, 10, [inputLength UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 11, [inputLengthPercent UTF8String] , -1, SQLITE_TRANSIENT); 
			//NSLog(@" %@ ",inputHeight);
			
			if(SQLITE_DONE != sqlite3_step(compiledStatement)){
				NSAssert1(0, @"Error while inserting into Tb_Growth_History. '%s'", sqlite3_errmsg(database));
			}
			//	sqlite3_reset(compiledStatement);
			//	sqlite3_close(database);
			
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
			
		}
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
}

//이력 조회

//SQL수행 부분 입력값은 View에서 받은 값
-(void) retrieveHistoryFromDatabase:(NSString*)inputName{
	
	sqlite3 *database;
	
	// Init the DBData Array
	if(self.isFirstTimeAccess == TRUE)
	{
		self.DBData = [[NSMutableArray alloc] init];
		self.isFirstTimeAccess = FALSE;
	}
	else
	{
		[self.DBData removeAllObjects];
	}
	// Open the database from the users filessytem
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT MP_Index,Child_Name ,Gender ,tb.Current_Date ,Birth_Year ,Birth_Month ,Height_Value ,Height_Percent ,Weight_Value ,Weight_Percent ,Leight_Value ,Leight_Percent from Tb_Growth_History tb  where Child_Name like '%'||? order by length(Birth_Year) desc, Birth_Year desc, length(Birth_Month) desc,Birth_Month desc";
		
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_text(compiledStatement, 1, [inputName UTF8String],  -1, SQLITE_TRANSIENT);
			
			
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				NSInteger pIndex2 = sqlite3_column_int(compiledStatement, 0);//인덱스 값
				NSString *Child_Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *Gender_Value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *Current_Date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				NSString *Birth_Year = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				NSString *Birth_Month = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
				NSString *Height_Value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
				NSString *Height_Percent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
				NSString *Weight_Value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];
				NSString *Weight_Percent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
				NSString *Leight_Value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)];
				NSString *Leight_Percent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)];
				
				
				NSString *tempDate=[Current_Date substringToIndex:4];//년구하기
				tempDate=[tempDate stringByAppendingString:@"-"];
				
				NSString *tempDate2=[Current_Date substringFromIndex:4];//년구하기
				
				tempDate=[tempDate stringByAppendingString:[tempDate2 substringToIndex:2]];
				tempDate=[tempDate stringByAppendingString:@"-"];
				tempDate=[tempDate stringByAppendingString:[tempDate2 substringFromIndex:2]];
				
				
				
				InfantData *md = [[InfantData alloc] initHistoryWithData:pIndex2 Name:Child_Name Gender:Gender_Value Date:tempDate Year:Birth_Year  Month:Birth_Month Height:Height_Value HeightPercent:Height_Percent Weight:Weight_Value  WeightPercent:Weight_Percent Length:Leight_Value LengthPercent:Leight_Percent];
				
				[self.DBData addObject:md];
				[md release];
			}
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
}

//SQL수행 부분 입력값은 View에서 받은 값
-(void) retrieveChildNameFromDatabase{
	
	sqlite3 *database;
	
	// Init the DBData Array
	if(self.isFirstTimeAccess == TRUE)
	{
		self.DBData = [[NSMutableArray alloc] init];
		self.isFirstTimeAccess = FALSE;
	}
	else
	{
		[self.DBData removeAllObjects];
	}
	
	// Open the database from the users filessytem
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT distinct(Child_Name)  from Tb_Growth_History order by length(Birth_Year) desc, Birth_Year desc, length(Birth_Month) desc,Birth_Month desc";		
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				//NSInteger pIndex2 = sqlite3_column_int(compiledStatement, 0);//인덱스 값
				NSString *Child_Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				
				InfantData *md = [[InfantData alloc] initHistoryWithData:Child_Name];
				
				[self.DBData addObject:md];
				[md release];
			}
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
}



//이력저장
-(void) deleteHistoryToDatabase:(NSString*)inputIndex{
	
	sqlite3 *database;
	// Init the DBData Array
	if(self.isFirstTimeAccess == TRUE)
	{
		self.DBData = [[NSMutableArray alloc] init];
		self.isFirstTimeAccess = FALSE;
	}
	else
	{
		[self.DBData removeAllObjects];
	}
	
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		//INSERT INTO tblMemoPad(MP_Title, MP_Content, MP_Date) VALUES('Sample data 1','Hello! This is a sample content 1','2010-01-01 00:00:00');
		
		const char *sqlStatement = "delete from Tb_Growth_History where MP_Index=?;";
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			sqlite3_bind_text(compiledStatement, 1, [inputIndex UTF8String], -1, SQLITE_TRANSIENT);
			NSLog(@" %@ ",inputIndex);
			
			if(SQLITE_DONE != sqlite3_step(compiledStatement)){
				NSAssert1(0, @"Error while delete from Tb_Growth_History. '%s'", sqlite3_errmsg(database));
			}
			//	sqlite3_reset(compiledStatement);
			//	sqlite3_close(database);
			
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
			
		}
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
}


//DB
- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

