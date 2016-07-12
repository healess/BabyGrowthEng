//
//  FaceBookShareViewController.h
//  BABYGROWTH
//
//  Created by JUNG-BUM SEO on 12. 7. 8..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "BABYGROWTHAppDelegate.h"
@protocol FaceBookShareViewControllerDelegate;

@interface FaceBookShareViewController : UIViewController <FBSessionDelegate, FBRequestDelegate, FBDialogDelegate>
{
	id<FaceBookShareViewControllerDelegate>delegate;

	Facebook *facebook;//페이스북
	UIActivityIndicatorView *activityIndicator;
	IBOutlet UIButton *btnLoginOut;
	IBOutlet UIButton *btnFeed;
	IBOutlet UIButton *btnPhoto;
	IBOutlet UIButton *btnClose;
	IBOutlet UITextView *textView;
}
@property (nonatomic, assign) id <FaceBookShareViewControllerDelegate> delegate;
@property (nonatomic, retain) Facebook *facebook; //페이스북
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator; 
@property (nonatomic, retain) IBOutlet UIButton *btnLoginOut;
@property (nonatomic, retain) IBOutlet UIButton *btnFeed;
@property (nonatomic, retain) IBOutlet UIButton *btnPhoto;
@property (nonatomic, retain) IBOutlet UIButton *btnClose;
@property (nonatomic, retain) UITextView *textView;

-(IBAction)cancel:(id)sender;
-(IBAction) FACEBOOK_LOGINOUT;
-(IBAction) FACEBOOK_FEED;
-(IBAction) GRAPH_TEST;
-(UIImage *)captureScreenInRect:(CGRect)captureFrame;
@end



@protocol FaceBookShareViewControllerDelegate
-(void) faceBookShareViewControllerDidFinish:(FaceBookShareViewController*)controller;
@end



