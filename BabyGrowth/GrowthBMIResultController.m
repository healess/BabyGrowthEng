//
//  GrowthBMIResultController.m
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import "GrowthBMIResultController.h"
#import "BABYGROWTHAppDelegate.h"
#import "InfantData.h"
#import <QuartzCore/QuartzCore.h>

@implementation GrowthBMIResultController
@synthesize btnCancel;

@synthesize Gender; 
@synthesize Year; 
@synthesize Month; 
@synthesize BMIValue; 
@synthesize BMIPercent; 
@synthesize infoComment;
@synthesize	infoWebComment;		//정보 2012.3.4 추가 by 서정범
@synthesize ivScale;
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
-(void) measureBMIPercent:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight Weight:(NSString*)pWeight
{
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
	
	NSLog(@" %i ",liveYear);
	NSLog(@" %i ",liveMonth);
	
	
	//미국단위 추가 (2012.10)
	NSString *heightResult;
	NSString *weightResult;
	//문자열 포함 검색을 통한 ft및 cm체크
	if ([pHeight rangeOfString:@"ft"].location != NSNotFound) {
		NSString *height1 =[pHeight substringToIndex:1];//ft가져오기
		NSString *height2 =[pHeight substringFromIndex:4];//in가져오기
		height2 = [height2 stringByReplacingOccurrencesOfString:@"in" withString:@""];//계산을 위한 in값 잘라내기 
		//위 방식도 가능 --> urlString = [urlString substringFromIndex:[urlString length]-1];
		float height3=[height1 floatValue];
		float height4=[height2 floatValue];
		height3=height3*30.48f;
		height4=height4*2.54f;
		height3=height3+height4;
		height3=(int)((height3+0.05f)*10)/10.0f;
		heightResult=[[NSString alloc] initWithFormat:@"%.1f", height3];//반올림하여 소수점 한자리만 출력
		NSLog(@"단위 변환 결과 (키) : %@ ",heightResult);
	}
	//cm인경우
	else {
		//NSLog(@"단위 변환 결과 (키:cm) : %@ ",inputHeight);
		//heightResult=inputHeight;
		heightResult = [pHeight stringByReplacingOccurrencesOfString:@"cm" withString:@""];//계산을 위한 in값 잘라내기 
		//NSLog(@"단위 변환 결과 (키:cm) : %@ ",inputHeight);
		
	}
	//몸무게 계산
	if ([pWeight rangeOfString:@"lb"].location != NSNotFound) {
		NSString *weight1 = [pWeight stringByReplacingOccurrencesOfString:@"lbs" withString:@""];//계산을 위한 lbs값 잘라내기
		//위 방식도 가능 --> urlString = [urlString substringFromIndex:[urlString length]-1];
		float weight2=[weight1 floatValue];
		weight2=weight2*0.453f;
		weightResult=[[NSString alloc] initWithFormat:@"%.2f", weight2];//반올림하여 소수점 한자리만 출력
		NSLog(@"단위 변환 결과 (몸무게) : %@ ",weightResult);
	}
	//kg인경우
	else {
		weightResult = [pWeight stringByReplacingOccurrencesOfString:@"kg" withString:@""];//계산을 위한 in값 잘라내기 		
	}	
	//미국단위 추가 (2012.10)
	
	
	float heightValue;
	heightValue=[heightResult floatValue];	
	float weightValue;
	weightValue=[weightResult floatValue];
	
	float fBMIValue=weightValue/(heightValue/100*heightValue/100);
	fBMIValue = lroundf(100.0f * fBMIValue) / 100.0f;
	
	int iBMIValueTemp=fBMIValue*100.0f;
	fBMIValue=iBMIValueTemp/100.0f;
	NSString *sBMIValue=[[NSString alloc] initWithFormat:@"%.2f", fBMIValue];
	self.BMIValue.text=sBMIValue;

	BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate calculateBMIFromDatabase:pGender Year:[[NSString alloc] initWithFormat:@"%i", liveYear] Month:[[NSString alloc] initWithFormat:@"%i", liveMonth] BMI:sBMIValue];
	InfantData *mData = [[appDelegate DBData] objectAtIndex:0];
	
	self.Gender.text=pGender;
	self.BMIPercent.text=mData.mPercent;
	self.Gender.text=pGender;
	self.Year.text=pYear;
	self.Month.text=pMonth;

	
	/*
	NSString *babyInfo ;	
	babyInfo=@"태어난지 ";
	babyInfo=[babyInfo stringByAppendingString:[[NSString alloc] initWithFormat:@"%i", liveYear]];
	babyInfo=[babyInfo stringByAppendingString:@"년 "];
	babyInfo=[babyInfo stringByAppendingString:[[NSString alloc] initWithFormat:@"%i", liveMonth]];
	babyInfo=[babyInfo stringByAppendingString:@"개월 된 "];
	
	if([pGender isEqualToString:@"B"])
	{
		babyInfo=[babyInfo stringByAppendingString:@"남"];
	}
	else 
	{
		babyInfo=[babyInfo stringByAppendingString:@"여"];
	}
		
	babyInfo=[babyInfo stringByAppendingString:@"자아이입니다.\n\nBMI의 값은 "];
	babyInfo=[babyInfo stringByAppendingString:sBMIValue];
	
	if(![mData.mPercent isEqualToString:@"표준범위초과"]){
	babyInfo=[babyInfo stringByAppendingString:@"입니다.\n\nBMI값을 동일 또래와 비교할 경우 하위 "];
	babyInfo=[babyInfo stringByAppendingString:mData.mPercent];
	babyInfo=[babyInfo stringByAppendingString:@"% 범위에 속합니다.\n\n하위 "];
	babyInfo=[babyInfo stringByAppendingString:mData.mPercent];
	babyInfo=[babyInfo stringByAppendingString:@"% 란 같은 또래 아이의 100명을 기준으로 마른순을 1번으로하였을때 "];
	babyInfo=[babyInfo stringByAppendingString:mData.mPercent];
	babyInfo=[babyInfo stringByAppendingString:@"번째를 의미합니다."];
	}else {
		babyInfo=[babyInfo stringByAppendingString:@"입니다.\n\nBMI값을 동일 또래와 비교할 때 표준범위를 초과한다고 판단됩니다."];
		babyInfo=[babyInfo stringByAppendingString:@"\n\nBMI값을 일반적으로 아이의 경우 10과 20사이의 범위에 속하기 때문입니다."];
	}

	
	
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
	
	babyWebInfo=[babyWebInfo stringByAppendingString:@"<BR><BR>BMI is <font color='#FF0000'><b>"];
	babyWebInfo=[babyWebInfo stringByAppendingString:sBMIValue];
	babyWebInfo=[babyWebInfo stringByAppendingString:@"</b></font>.<BR><BR>"];
	if(![mData.mPercent isEqualToString:@"표준범위초과"])
	{
		babyWebInfo=[babyWebInfo stringByAppendingString:@"BMI is in the bottom of <font color='#FF0000'><b>"];
		babyWebInfo=[babyWebInfo stringByAppendingString:mData.mPercent];
		babyWebInfo=[babyWebInfo stringByAppendingString:@"% </b></font>by comparing it to the growth data of children of similar age.<BR><BR> In the bottom of "];
		babyWebInfo=[babyWebInfo stringByAppendingString:mData.mPercent];
		babyWebInfo=[babyWebInfo stringByAppendingString:@"% means  rank of "];
		babyWebInfo=[babyWebInfo stringByAppendingString:mData.mPercent];
		babyWebInfo=[babyWebInfo stringByAppendingString:@" among a similar cohort of 100 childrens in the order of thinness."];
	}
	else 
	{
		babyWebInfo=[babyWebInfo stringByAppendingString:@"<font color='FFFF99'><b>BMI exceed standards by comparing it to the growth data of children of similar age.</b></font>"];
		babyWebInfo=[babyWebInfo stringByAppendingString:@"<BR><BR>Child'd average bmi belongs to between 10 and 20."];
	}
	
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
	
	

	/* BMI=체중/(키*키)
	 float roundedValue = round(2.0f * number) / 2.0f;
	 NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	 [formatter setMaximumFractionDigits:1];
	 [formatter setRoundingMode: NSNumberFormatterRoundDown];
	 
	 NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
	 [formatter release];
	 
	 
	self.Year.text=pYear;
	self.Month.text=pMonth;
	self.Height.text=pHeight;
	self.HeightPercent.text=pHeightPercent;
	
	BABYGROWTHAppDelegate *appDelegate = (BABYGROWTHAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate calculateHeightPercentFromDatabase:pGender Year:pYear Month:pMonth HeightPercent:pHeightPercent];
	
	InfantData *mData = [[appDelegate DBData] objectAtIndex:0];
	
	NSLog(@" %@ ",mData.mPercent);
	
	self.FutureHeight.text=mData.mPercent;*/
	
	//급간에 따라 보여줄 이미지를 다르게 적용
	UIImageView *ivTemp;
	
	if([mData.mPercent isEqualToString:@"표준범위초과"])
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scale_abnormal.png"]];
	}
	else if([mData.mPercent intValue]<=30)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scale_weak.png"]];
	}
	else if([mData.mPercent intValue]<=70)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scale_normal.png"]];
	}
	else if([mData.mPercent intValue]<=100)
	{
		ivTemp=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scale_fat.png"]];
	}
	
	[ivScale addSubview:ivTemp];
	[ivTemp release];
	
	//최소한번은 실행했음.
	[[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"keyAtLeastOneUse"];
}

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
    [super dealloc];
}


@end
