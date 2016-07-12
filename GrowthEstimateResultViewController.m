//
//  GrowthEstimateResultViewController.m
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import "GrowthEstimateResultViewController.h"
#import "BABYGROWTHAppDelegate.h"
#import "InfantData.h"
#import <QuartzCore/QuartzCore.h>

@implementation GrowthEstimateResultViewController
@synthesize btnCancel;
@synthesize result_Boy;
@synthesize result_Girl;
@synthesize pFatherHeight;
@synthesize pMotherHeight;
@synthesize Gender;
@synthesize Year;
@synthesize Month;
@synthesize Height;
@synthesize HeightPercent;
@synthesize FutureHeight;
@synthesize infoComment;
@synthesize	infoWebComment;		//정보 2012.3.4 추가 by 서정범
@synthesize ivGiraffe; //기린^^
@synthesize timer;
@synthesize second;

//============================================================================================================
// 페이스북 공유 버튼 누를시.
//============================================================================================================
-(IBAction)btnFacebookShareTouched
{
	
	BABYGROWTHAppDelegate *appDelegate=(BABYGROWTHAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	
	//버튼을 숨긴후...
	btnCancel.hidden=YES;
	btnFacebookShare.hidden=YES;
	
	
	//화면캡쳐실시한다-레티나인지 아닌지 구별해서..
	if ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] )
	{
		if ( [[UIScreen mainScreen] scale] == 2.0) 
		{
			//레티나
			appDelegate.capturedImage=[self captureScreenInRect:CGRectMake(0,0,640,960)];
			NSLog(@"본기기는 레티나 디스플레이임 (640x960)");
		} 
		else 
		{    
			//일반	
			appDelegate.capturedImage=[self captureScreenInRect:CGRectMake(0,0,320,480)];
			NSLog(@"본기기는 일반 디스플레이임  (320x480)");
		}
	}	
	
	//다시버튼을 보여준다.
	btnCancel.hidden=NO;
	btnFacebookShare.hidden=NO;
	
	
	//모달 디스플레이
	FaceBookShareViewController *controller=[[FaceBookShareViewController alloc] initWithNibName:@"FaceBookShareViewController" bundle:nil];
	controller.delegate=self;
	
	controller.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:controller animated:YES];
}

/*====================================================================================
 캡쳐한다.
 ====================================================================================*/
- (UIImage *)captureScreenInRect:(CGRect)captureFrame
{ 
	
	CALayer *layer; 
    layer = self.view.layer; 
    
	//레티나인지 아닌지 구별해서..
	if ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] )
	{
		if ( [[UIScreen mainScreen] scale] == 2.0) 
		{
			//레티나
			UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.5);
		} 
		else 
		{    
			//일반	
			//UIGraphicsBeginImageContext(self.view.bounds.size); //일반...
			UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.5);
		}
	}
	
	CGContextClipToRect (UIGraphicsGetCurrentContext(),captureFrame); 
    [layer renderInContext:UIGraphicsGetCurrentContext()]; 
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext(); 
    UIGraphicsEndImageContext(); 
    return screenImage; 	
} 




//============================================================================================================
// 팝업닫기
//============================================================================================================

-(void) faceBookShareViewControllerDidFinish:(FaceBookShareViewController*)controller
{
	[self dismissModalViewControllerAnimated:YES];
	//[tableView reloadData];
	
}


/*======================================================================================
 뷰가나타날때 리뷰쓰라고 권고하는 창을 띄워주기 위해 대기하는 타이머
 ======================================================================================*/
-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	self.timer=[NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(UPDATE_TIME) userInfo:nil repeats:YES];		
	[self setSecond:0];
	
}

/*======================================================================================
 뷰가 사라질때는 타이머를 뜬다.
 ======================================================================================*/

-(void) viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:YES];
	[self setSecond:0];
	[self.timer invalidate];
}


/*======================================================================================
 타이머에 의해 호출되는 함수
 ======================================================================================*/
-(void) UPDATE_TIME
{
	
	int newsecond=[self second]+1;
	[self setSecond:newsecond];	
	NSLog(@"Second:%d",[self second]);
	
	if([self second]>=3)
	{
		[self setSecond:0];
		[self.timer invalidate];//타이머 멈춤
		BABYGROWTHAppDelegate *appDelegate=(BABYGROWTHAppDelegate*)[[UIApplication sharedApplication] delegate];
		[appDelegate ShowMessageBoxRequireReview];
	}
}

/*
-(void)viewWillAppear:(BOOL)animated
{
	//급간에 따라 보여줄 이미지를 다르게 적용
	UIImageView *ivTemp;
	
	NSLog(@">>>>>> %@ ",self.HeightPercent.text);
	if([self.HeightPercent.text intValue]<=30)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"giraffe_low.png"]];
	}
	else if([self.HeightPercent.text intValue]<=70)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"giraffe_middle.png"]];
	}
	else if([self.HeightPercent.text intValue]<=100)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"giraffe_high.png"]];
	}
	[ivGiraffe addSubview:ivTemp];
	[ivTemp release];
	
}
 */

-(IBAction) btnCancelTouched
{
	//[self.navigationController popViewControllerAnimated:YES];
	[self.navigationController popToRootViewControllerAnimated:YES];

}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
/*
-(void)calcualteParentHeightValue:(NSString *)inputFather Mother:(NSString*)inputMother{
	int fatherHeight=[inputFather intValue];
	int motherHeight=[inputMother intValue];
//	NSLog(@" %@ ",fatherHeight);
	int expectBoyHeight=(fatherHeight+motherHeight)/2+6.5;
	int expectGirlHeight=(fatherHeight+motherHeight)/2-6.5;
//	NSLog(@" %@ ",expectGirlHeight);

	self.result_Boy.text=[[NSString alloc] initWithFormat:@"%d", expectBoyHeight];//[[NSString alloc] initWithFormat:@"%d",b];
	self.result_Girl.text=[[NSString alloc] initWithFormat:@"%d", expectGirlHeight];
	
	self.pFatherHeight.text=inputFather;
	self.pMotherHeight.text=inputMother;	
}*/
-(void) calcualteCurrentHeightValue:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight HeightPercent:(NSString*)pHeightPercent Father:(NSString *)inputFather Mother:(NSString*)inputMother
{
	//부모키계산
	
	//int fatherHeight=[inputFather intValue];
	//int motherHeight=[inputMother intValue];

	float fatherHeight;
	float motherHeight;
	//미국단위 추가 (2012.10)
	//출력값 ft in cm 출력 보완
	NSString *heightFatherResult;
	NSString *heightMotherResult;
	
	//문자열 포함 검색을 통한 ft및 cm체크
	if ([inputFather rangeOfString:@"ft"].location != NSNotFound) {
		NSString *height1 =[inputFather substringToIndex:1];//ft가져오기
		NSString *height2 =[inputFather substringFromIndex:4];//in가져오기
		height2 = [height2 stringByReplacingOccurrencesOfString:@"in" withString:@""];//계산을 위한 in값 잘라내기 
		//위 방식도 가능 --> urlString = [urlString substringFromIndex:[urlString length]-1];
		float height3=[height1 floatValue];
		float height4=[height2 floatValue];
		height3=height3*30.48f;
		height4=height4*2.54f;
		height3=height3+height4;
		height3=(int)((height3+0.05f)*10)/10.0f;
		fatherHeight=height3;
		//heightFatherResult=[[NSString alloc] initWithFormat:@"%.1f", height3];//반올림하여 소수점 한자리만 출력
		NSLog(@"ft단위 변환 결과 (아빠키cm) : %.1f ",fatherHeight);
	}
	//cm인경우
	else {
		//NSLog(@"단위 변환 결과 (키:cm) : %@ ",inputHeight);
		//heightResult=inputHeight;
		heightFatherResult = [inputFather stringByReplacingOccurrencesOfString:@"cm" withString:@""];//계산을 위한 in값 잘라내기 
		fatherHeight=[heightFatherResult floatValue];
		NSLog(@"cm단위 변환 결과 (아빠키:cm) : %@",heightFatherResult);
	}	
	//문자열 포함 검색을 통한 ft및 cm체크
	if ([inputMother rangeOfString:@"ft"].location != NSNotFound) {
		NSString *height1 =[inputMother substringToIndex:1];//ft가져오기
		NSString *height2 =[inputMother substringFromIndex:4];//in가져오기
		height2 = [height2 stringByReplacingOccurrencesOfString:@"in" withString:@""];//계산을 위한 in값 잘라내기 
		//위 방식도 가능 --> urlString = [urlString substringFromIndex:[urlString length]-1];
		float height3=[height1 floatValue];
		float height4=[height2 floatValue];
		height3=height3*30.48f;
		height4=height4*2.54f;
		height3=height3+height4;
		height3=(int)((height3+0.05f)*10)/10.0f;
		motherHeight=height3;
		//heightMotherResult=[[NSString alloc] initWithFormat:@"%.1f", height3];//반올림하여 소수점 한자리만 출력
		NSLog(@"ft단위 변환 결과 (엄마키cm) : %.1f ",motherHeight);
	}
	//cm인경우
	else {
		//NSLog(@"단위 변환 결과 (키:cm) : %@ ",inputHeight);
		//heightResult=inputHeight;
		heightMotherResult = [inputMother stringByReplacingOccurrencesOfString:@"cm" withString:@""];//계산을 위한 in값 잘라내기 
		motherHeight=[heightMotherResult floatValue];
		NSLog(@"cm단위 변환 결과 (엄마키:cm) : %@",heightMotherResult);
	}		
	

	
	
	
	float expectBoyHeight=(fatherHeight+motherHeight)/2.0f+7;
	NSString *boyHeightResultCm=[[NSString alloc] initWithFormat:@"%.1f", expectBoyHeight];//반올림하여 소수점 한자리만 출력
	float expectGirlHeight=(fatherHeight+motherHeight)/2.0f-6;
	NSString *girlHeightResultCm=[[NSString alloc] initWithFormat:@"%.1f", expectGirlHeight];//반올림하여 소수점 한자리만 출력
	
	NSLog(@"여자아이 예상키 : %.1f ",expectGirlHeight);
	NSLog(@"남자아이 예상키 : %.1f ",expectBoyHeight);
	

	//남자아이키 계산
	float boyHeightIn=expectBoyHeight*0.393f;
	int boyHeightFt=boyHeightIn/12;
	boyHeightIn=boyHeightIn-boyHeightFt*12;
	NSString *boyHeightResultFt=[[NSString alloc] initWithFormat:@"%i", boyHeightFt];//ft
	NSLog(@"남자아이 ft 변환 : %@",boyHeightResultFt);

	NSString *boyHeightResultIn=[[NSString alloc] initWithFormat:@"%.1f", boyHeightIn];//in
	
	NSString *expectBoyHeightResult=@"";
	
	expectBoyHeightResult=[expectBoyHeightResult stringByAppendingString:boyHeightResultFt];	
	expectBoyHeightResult=[expectBoyHeightResult stringByAppendingString:@"ft "];
	expectBoyHeightResult=[expectBoyHeightResult stringByAppendingString:boyHeightResultIn];	
	expectBoyHeightResult=[expectBoyHeightResult stringByAppendingString:@"in"];
	
	expectBoyHeightResult=[expectBoyHeightResult stringByAppendingString:@"("];
	expectBoyHeightResult=[expectBoyHeightResult stringByAppendingString:boyHeightResultCm];
	expectBoyHeightResult=[expectBoyHeightResult stringByAppendingString:@"cm"];	
	expectBoyHeightResult=[expectBoyHeightResult stringByAppendingString:@")"];
	NSLog(@"남자아이 예상키 종합 : %@ ",expectBoyHeightResult);
	
	//여자아이키 계산
	float girlHeightIn=expectGirlHeight*0.393f;
	int girlHeightFt=girlHeightIn/12;
	girlHeightIn=girlHeightIn-boyHeightFt*12;
	NSString *girlHeightResultFt=[[NSString alloc] initWithFormat:@"%i", girlHeightFt];//ft
	NSLog(@"남자아이 ft 변환 : %@",girlHeightResultFt);
	
	NSString *girlHeightResultIn=[[NSString alloc] initWithFormat:@"%.1f", girlHeightIn];//in
	
	NSString *expectGirlHeightResult=@"";//NULL값셋팅 반드시 필요(미 초기화시 잘못된 값 출력)
	
	expectGirlHeightResult=[expectGirlHeightResult stringByAppendingString:girlHeightResultFt];	
	expectGirlHeightResult=[expectGirlHeightResult stringByAppendingString:@"ft "];
	expectGirlHeightResult=[expectGirlHeightResult stringByAppendingString:girlHeightResultIn];	
	expectGirlHeightResult=[expectGirlHeightResult stringByAppendingString:@"in"];
	
	expectGirlHeightResult=[expectGirlHeightResult stringByAppendingString:@"("];
	expectGirlHeightResult=[expectGirlHeightResult stringByAppendingString:girlHeightResultCm];
	expectGirlHeightResult=[expectGirlHeightResult stringByAppendingString:@"cm"];	
	expectGirlHeightResult=[expectGirlHeightResult stringByAppendingString:@")"];
	NSLog(@"여자아이 예상키 종합 : %@ ",expectGirlHeightResult);	
	//미국단위 추가 (2012.10)		
	
	
	self.result_Boy.text=[[NSString alloc] initWithFormat:@"%.1f", expectBoyHeight];//남자아이
	self.result_Girl.text=[[NSString alloc] initWithFormat:@"%.1f", expectGirlHeight];
	
	self.pFatherHeight.text=inputFather;
	self.pMotherHeight.text=inputMother;	
	
	
	//아이미래키계산 
	self.Gender.text=pGender;
	self.Year.text=pYear;
	self.Month.text=pMonth;
	self.Height.text=pHeight;
	self.HeightPercent.text=pHeightPercent;
	
	//날짜변환
	NSDate* today = [NSDate date];
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:@"yyyy-MM"];
	NSString *str1 =[dateFormatter stringFromDate:today];	
	NSString *str2 =[dateFormatter stringFromDate:today];	
	
	str1=[str1 substringToIndex:4];//년구하기
	str2=[str2 substringFromIndex:5];//월구하기
	int currentYear=[str1 intValue];
	int currentMonth=[str2 intValue];
	
	int birthYear=[pYear intValue];
	int birthMonth=[pMonth intValue];
	
	int liveYear=currentYear-birthYear;
	int liveMonth=12;
	if (liveYear>0 && birthMonth==currentMonth) {
		liveMonth=12;
		liveYear--;
	}
	else if(birthMonth>currentMonth){
		liveMonth=currentMonth+12-birthMonth;
		liveYear--;
	}else {
		liveMonth=currentMonth-birthMonth;
	}
	
	//NSLog(@" %i ",liveYear);
	//NSLog(@" %i ",liveMonth);
	
	BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate calculateHeightPercentFromDatabase:pGender Year:[[NSString alloc] initWithFormat:@"%i", liveYear] Month:[[NSString alloc] initWithFormat:@"%i", liveMonth]  HeightPercent:pHeightPercent];
	
	InfantData *mData = [[appDelegate DBData] objectAtIndex:0];

	//NSLog(@" %@ ",mData.mPercent);
	
	
	//미국단위 추가 (2012.10)
	//출력값 ft in cm 출력 보완
	NSString *heightResult=mData.mPercent;
	
	float heightIn=[heightResult floatValue];
	heightIn=heightIn*0.393f;
	
	int heightFt=heightIn/12;
	heightIn=heightIn-heightFt*12;

	NSString *heightResultFt=[[NSString alloc] initWithFormat:@"%i", heightFt];//ft
	NSString *heightResultIn=[[NSString alloc] initWithFormat:@"%.1f", heightIn];//in

	
	NSString *heightResult3=@"";
	
	heightResult3=[heightResult3 stringByAppendingString:heightResultFt];	
	heightResult3=[heightResult3 stringByAppendingString:@"ft "];
	heightResult3=[heightResult3 stringByAppendingString:heightResultIn];	
	heightResult3=[heightResult3 stringByAppendingString:@"in"];
	
	heightResult3=[heightResult3 stringByAppendingString:@"("];
	heightResult3=[heightResult3 stringByAppendingString:heightResult];
	heightResult3=[heightResult3 stringByAppendingString:@"cm"];	
	heightResult3=[heightResult3 stringByAppendingString:@")"];

	self.FutureHeight.text=heightResult;	
	//미국단위 추가 (2012.10)	
	
	//self.FutureHeight.text=mData.mPercent;
	
	
	/*
	NSString *babyInfo ;	
	babyInfo=@"태어난지 ";
	babyInfo=[babyInfo stringByAppendingString:[[NSString alloc] initWithFormat:@"%i", liveYear]];
	babyInfo=[babyInfo stringByAppendingString:@"년 "];
	babyInfo=[babyInfo stringByAppendingString:[[NSString alloc] initWithFormat:@"%i", liveMonth] ];
	babyInfo=[babyInfo stringByAppendingString:@"개월 된 "];
	
	if([pGender isEqualToString:@"B"])
	{
		babyInfo=[babyInfo stringByAppendingString:@"남"];
	}
	else 
	{
		babyInfo=[babyInfo stringByAppendingString:@"여"];
	}
	if(![mData.mPercent isEqualToString:@"표준범위초과"]){

	babyInfo=[babyInfo stringByAppendingString:@"자아이입니다.\n\n키의 경우 하위 "];
	babyInfo=[babyInfo stringByAppendingString:pHeightPercent];
	babyInfo=[babyInfo stringByAppendingString:@"% 범위에 속합니다.\n\n아이가 이범위로 성장하였을 때 예상되는 키는 "];
	babyInfo=[babyInfo stringByAppendingString:mData.mPercent];
	babyInfo=[babyInfo stringByAppendingString:@" cm 입니다."];
	}else {
		babyInfo=[babyInfo stringByAppendingString:@"자아이입니다.\n\n키의 동일 또래와 비교할 때 표준범위를 초과한다고 판단됩니다."];
	}

	babyInfo=[babyInfo stringByAppendingString:@"\n\n부모키와 비교하였을 때 아빠키 "];
	babyInfo=[babyInfo stringByAppendingString:inputFather];
	babyInfo=[babyInfo stringByAppendingString:@" cm 와 엄마키 "];
	babyInfo=[babyInfo stringByAppendingString:inputMother];
	babyInfo=[babyInfo stringByAppendingString:@" cm 를 토대로 유전적으로 성인이 되었을 때 예상되는 키는 "];
	
	if([pGender isEqualToString:@"B"])
	{
		babyInfo=[babyInfo stringByAppendingString:[[NSString alloc] initWithFormat:@"%d", expectBoyHeight]];
	}
	else 
	{
		babyInfo=[babyInfo stringByAppendingString:[[NSString alloc] initWithFormat:@"%d", expectGirlHeight]];
	}
	
	babyInfo=[babyInfo stringByAppendingString:@" cm 입니다."];
	
	[infoComment setFont:[UIFont boldSystemFontOfSize:13.5]]; //폰트사이즈
	infoComment.text=babyInfo;
	infoComment.backgroundColor = [UIColor clearColor];	
	*/
	
	
	//아래코드는 커맨트를 HTML 로 처리하기 위한 방법... 2012.3.4 by 서정범
	NSString *babyWebInfo ;
	babyWebInfo=@"";
	babyWebInfo=[babyWebInfo stringByAppendingString:@"<HTML>"];
	babyWebInfo=[babyWebInfo stringByAppendingString:@"<BODY STYLE='background-color: transparent'>"];
	babyWebInfo=[babyWebInfo stringByAppendingString:@"<FONT SIZE='2' COLOR='#666666'>"];
	
	babyWebInfo=[babyWebInfo stringByAppendingString:@"A baby "];
	
	if([pGender isEqualToString:@"B"])
	{
		babyWebInfo=[babyWebInfo stringByAppendingString:@"boy"];
	}
	else 
	{
		babyWebInfo=[babyWebInfo stringByAppendingString:@"girl"];
	}	
	babyWebInfo=[babyWebInfo stringByAppendingString:@" was "];	
	
	babyWebInfo=[babyWebInfo stringByAppendingString:[[NSString alloc] initWithFormat:@"%i", liveYear]];
	babyWebInfo=[babyWebInfo stringByAppendingString:@"year(s) and "];
	babyWebInfo=[babyWebInfo stringByAppendingString:[[NSString alloc] initWithFormat:@"%i", liveMonth] ];
	babyWebInfo=[babyWebInfo stringByAppendingString:@" month(s) old."];
	
	if(![mData.mPercent isEqualToString:@"표준범위초과"]){
		
		babyWebInfo=[babyWebInfo stringByAppendingString:@"<BR><BR>Height is in the bottom of <font color='#FF0000'><b>"];
		babyWebInfo=[babyWebInfo stringByAppendingString:pHeightPercent];
		babyWebInfo=[babyWebInfo stringByAppendingString:@"% </b></font>.<BR>Child's adult height will be <font color='#FF0000'><b>"];
		//미국단위 추가 (2012.10)
		//babyWebInfo=[babyWebInfo stringByAppendingString:mData.mPercent];
		//babyWebInfo=[babyWebInfo stringByAppendingString:@" cm</b></font> by predicting based on child's current height."];
		babyWebInfo=[babyWebInfo stringByAppendingString:heightResult3];		
		babyWebInfo=[babyWebInfo stringByAppendingString:@"</b></font> by predicting based on child's current height."];
		
	}else {
		babyWebInfo=[babyWebInfo stringByAppendingString:@"<BR><BR><font color='FFFF99'><b>Height exceed standards by comparing it to the growth data of children of similar age.</b></font>"];
	}
	
	babyWebInfo=[babyWebInfo stringByAppendingString:@"<BR><BR>Child is growing to <font color='#FF0000'><b>"];
	
	

	if([pGender isEqualToString:@"B"])
	{
		//미국단위 추가 (2012.10)
		babyWebInfo=[babyWebInfo stringByAppendingString:expectBoyHeightResult];
		//babyWebInfo=[babyWebInfo stringByAppendingString:[[NSString alloc] initWithFormat:@"%.1f", expectBoyHeight]];
	}
	else 
	{
		//미국단위 추가 (2012.10)
		babyWebInfo=[babyWebInfo stringByAppendingString:expectGirlHeightResult];		
		//babyWebInfo=[babyWebInfo stringByAppendingString:[[NSString alloc] initWithFormat:@"%.1f", expectGirlHeight]];
	}
	babyWebInfo=[babyWebInfo stringByAppendingString:@"</b></font> by predicting child's parents' heights (Father "];
	babyWebInfo=[babyWebInfo stringByAppendingString:inputFather];
	//미국단위 추가 (2012.10)
	babyWebInfo=[babyWebInfo stringByAppendingString:@", Mother "];
	babyWebInfo=[babyWebInfo stringByAppendingString:inputMother];
	//미국단위 추가 (2012.10)	
	babyWebInfo=[babyWebInfo stringByAppendingString:@")."];
	
	babyWebInfo=[babyWebInfo stringByAppendingString:@"</FONT>"];
	babyWebInfo=[babyWebInfo stringByAppendingString:@"</BODY>"];
	babyWebInfo=[babyWebInfo stringByAppendingString:@"</HTML>"];
	
	
	//HTML 로드 
	[infoWebComment setBackgroundColor:[UIColor clearColor]]; 
	[infoWebComment setOpaque:NO]; //배경을 투명하게
	id scrollView = [infoWebComment.subviews objectAtIndex:0];
	for (UIView *subview in [scrollView subviews]) {
		if ([subview isKindOfClass:[UIImageView class]]) {
			subview.hidden = YES;
		}
	}		
	
	[infoWebComment loadHTMLString:babyWebInfo baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
	
	
	//급간에 따라 보여줄 이미지를 다르게 적용
	UIImageView *ivTemp;
	
	if([pHeightPercent isEqualToString:@"표준범위초과"])
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"giraffe_abnormal.png"]];
	}
	else if([pHeightPercent intValue]<=30)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"giraffe_low.png"]];
	}
	else if([pHeightPercent intValue]<=70)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"giraffe_middle.png"]];
	}
	else if([pHeightPercent intValue]<=100)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"giraffe_high.png"]];
	}
	[ivGiraffe addSubview:ivTemp];
	[ivTemp release];
	
	//최소한번은 실행했음.
	[[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"keyAtLeastOneUse"];
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
