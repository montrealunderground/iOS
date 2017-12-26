//
//  PlaceListViewController.h
//  iXplorCanada
//
//  Created by Kang on 6/10/14.
//  Copyright (c) 2014 com.xplor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "NHCalendarActivity.h"
#import "GlobalVariable.h"

#define kGOOGLE_API_KEY @"AIzaSyDyWCoV5_luhS16_S3_ARn5qA29t8_k-V8"

@protocol MapPlaceListViewControllerDelegate<NSObject>
-(void) onGotoStore:(NSString*)storename link:(NSString*)link;
@end
@interface MapPlaceListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,  NHCalendarActivityDelegate, NSXMLParserDelegate>
{
    UIStoryboard* storyboard ;
   
    NSString* place_phone ;
    NSString* place_name ;
    NSString* place_address ;
    NSString* place_description ;
    
    int nSelected_row ;
    NSInteger intTmp ;
    
    NSString * storename;
    NSString * link;
    NSString * shareData;
}

@property (strong, nonatomic) UIActivityViewController*     activity ;
- (IBAction)onCloseDetail:(id)sender ;

- (IBAction)onShare:(id)sender ;
- (IBAction)onCall:(id)sender ;
- (IBAction)onMap:(id)sender ;

@property (nonatomic, retain) IBOutlet UITableView*         mtable ;

@property (nonatomic, retain) IBOutlet UIView*              detailView ;
@property (nonatomic, retain) IBOutlet UILabel*             label_BizName ;
@property (nonatomic, retain) IBOutlet UITextView*          txt_Description ;

@property (nonatomic, retain) IBOutlet UIImageView*         imgBusiness ;
@property (nonatomic, retain) IBOutlet UIButton*            btnClose ;

@property (nonatomic, retain) IBOutlet UIButton*            btnCall ;
@property (nonatomic, retain) IBOutlet UIButton*            btnDirection ;
@property (nonatomic, retain) IBOutlet UIButton*            btnShare ;
@property (weak, nonatomic) IBOutlet UIImageView*           imgPromotion;

@property (nonatomic, strong) NSString*                     baseimageurl;
@property (nonatomic, strong) id <MapPlaceListViewControllerDelegate> delegate;
@end
