//
//  FaceBookShareViewController.m
//  BABYGROWTH
//
//  Created by JUNG-BUM SEO on 12. 7. 8..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FaceBookShareViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation FaceBookShareViewController
@synthesize delegate;
@synthesize activityIndicator;
@synthesize facebook;//페이스북
@synthesize btnLoginOut;
@synthesize btnFeed;
@synthesize btnPhoto;
@synthesize btnClose;
@synthesize textView;

-(IBAction)cancel:(id)sender
{
	[self.delegate faceBookShareViewControllerDidFinish:self];
}


-(void) ShowMessageBox:(NSString*)message
{
	UIAlertView *warn;
	warn= [[UIAlertView alloc]	initWithTitle:nil
									 message:message
									delegate:nil
						   cancelButtonTitle:@"확인"
						   otherButtonTitles:nil];
	
	[warn show];		
	[warn release];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	//페이스북인스턴스생성(성장진단:324669024288317)
    facebook = [[Facebook alloc] initWithAppId:@"324669024288317" andDelegate:self];  
	
	
	//페이스북로그인세션
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) 
	{
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
		//[btnLoginOut setTitle:@"Facebook Logout" forState:UIControlStateNormal];		
		[btnLoginOut setImage:[UIImage imageNamed:@"facebook_logout.png"] forState:UIControlStateNormal];
		[btnFeed setEnabled:YES];
		[btnPhoto setEnabled:YES];
	
		
		
	}	
	else
	{
		//[btnLoginOut setTitle:@"Facebook Login" forState:UIControlStateNormal];
		[btnLoginOut setImage:[UIImage imageNamed:@"facebook_login.png"] forState:UIControlStateNormal];
		[btnFeed setEnabled:NO];
		[btnPhoto setEnabled:NO];
		
	}
	
	//키보드를 자동으로..
	[textView becomeFirstResponder];
}

// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	NSLog(@"This is PRE iOS 4.2");
	return [facebook handleOpenURL:url]; 
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 
{
    NSLog(@"This is iOS 4.2+");	
	return [facebook handleOpenURL:url]; 
}


-(IBAction) FACEBOOK_LOGINOUT
{
	
	
	//로그인 되어 있지 않다면 로그인 하고 
	if (![facebook isSessionValid]) 
	{
		
		//키보드감추고
		[textView resignFirstResponder];
		
		//추가Permission
		NSArray *permissions = [[NSArray alloc] initWithObjects:
								@"user_likes", 
								@"read_stream",
								@"publish_stream",
								nil];
        
		//로그인
		//[[appDelegate facebook] authorize:nil];
		[facebook authorize:permissions];
        [permissions release];		
		
	}
	//로그인 되어 있다면 로그아웃 하라.
	else
	{
		[facebook logout]; 		
	}
}


-(IBAction) FACEBOOK_FEED
{
	[facebook dialog:@"feed" andDelegate:self];	
}


-(IBAction) GRAPH_TEST
{	
	
	if(![facebook isSessionValid])
	{
		[self ShowMessageBox:@"Enter your Facebook login and password."];//페이스북에 먼저로그인 해주세요
	}
	else
	{	
		BABYGROWTHAppDelegate *appDelegate=(BABYGROWTHAppDelegate*)[[UIApplication sharedApplication] delegate];
		
		//인디케이터 작동
		activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50 )];
		[activityIndicator setCenter:self.view.center];
		[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self.view addSubview:activityIndicator];
		
		[activityIndicator startAnimating];        
		[activityIndicator setHidden:NO];
		
		//버튼을 사용못하게
		[btnLoginOut setEnabled:NO];
		[btnFeed setEnabled:NO];
		[btnPhoto setEnabled:NO];
		[btnClose setEnabled:NO];
		
		
				
		//캡션과 함께 이미지 업로드
		NSString *caption;
		//caption=[[textView text] stringByAppendingString:@"\n\n[If you concerned about your baby diagnostics, install the Growth diagnostics app]\nhttp://itunes.apple.com/kr/app/seongjangjindan/id501316252?ls=1&mt=8"];
		caption=[textView text];
		NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
										[appDelegate capturedImage], @"picture", 
										caption,@"caption",
										nil];
			
			
		[facebook requestWithMethodName:@"photos.upload"
							  andParams:params
						  andHttpMethod:@"POST"
							andDelegate:self];		
	}
}




/*====================================================================================
 페이스북 로그인 핸들러
 ====================================================================================*/
- (void)fbDidLogin
{
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];	
	[defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];	
	//[btnLoginOut setTitle:@"Log-OUT" forState:UIControlStateNormal];
	[btnLoginOut setImage:[UIImage imageNamed:@"facebook_logout.png"] forState:UIControlStateNormal];
	[btnFeed setEnabled:YES];
	[btnPhoto setEnabled:YES];
	[btnClose setEnabled:YES];
	
	//키보드를 자동으로..
	[textView becomeFirstResponder];
	NSLog(@"로그인 성공");
	
}

/*====================================================================================
 페이스북 로그아웃 핸들러
 ====================================================================================*/
- (void) fbDidLogout 
{
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) 
	{
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
	//[btnLoginOut setTitle:@"Log-IN" forState:UIControlStateNormal];
	[btnLoginOut setImage:[UIImage imageNamed:@"facebook_login.png"] forState:UIControlStateNormal];
	[btnFeed setEnabled:NO];
	[btnPhoto setEnabled:NO];
	[textView becomeFirstResponder];
	NSLog(@"로그아웃 성공");	
	/*------------------------------------------------------------
	 Facebook.m 의 아래부분을 고쳐야 완벽하게 로그아웃되고 웹화면으로 처리됨.
	 //[self authorizeWithFBAppAuth:YES safariAuth:YES];
	 [self authorizeWithFBAppAuth:YES safariAuth:NO];	
	 ------------------------------------------------------------*/
}


/*====================================================================================
 리퀘스트 핸들러
 ====================================================================================*/

- (void)request:(FBRequest *)request didLoad:(id)result
{
	
	//버튼들을 원래대로
	[btnLoginOut setEnabled:YES];
	[btnFeed setEnabled:YES];
	[btnPhoto setEnabled:YES];
	
	//인디케이터 숨김
	[activityIndicator stopAnimating];        
    [activityIndicator setHidden:YES];
	NSLog(@"사진업로드 완료");
	
	[self ShowMessageBox:@"Uploaded to Facebook"];	//페이스북에 업로드 되었습니다.
	[self.delegate faceBookShareViewControllerDidFinish:self];
}


/*====================================================================================
 requestLoading
 ====================================================================================*/
- (void)requestLoading:(FBRequest *)request
{
}

/*====================================================================================
 didReceiveResponse
 ====================================================================================*/
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
	//NSLog(@"didReceiveResponse");
}

/*====================================================================================
 didFailWithError
 ====================================================================================*/

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
	NSLog(@"사진업로드 ERROR!");
}

- (void)didReceiveMemoryWarning 
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
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
	[facebook release];
	
}

@end
