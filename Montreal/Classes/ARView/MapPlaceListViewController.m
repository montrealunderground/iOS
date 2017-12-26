//
//  PlaceListViewController.m
//  iXplorCanada
//
//  Created by Kang on 6/10/14.
//  Copyright (c) 2014 com.xplor. All rights reserved.
//

#import "MapPlaceListViewController.h"
#import "GlobalVariable.h"
#import "NLCachedImageTableViewCell.h"

@interface MapPlaceListViewController ()

@end

@implementation MapPlaceListViewController
@synthesize label_BizName, txt_Description, imgPromotion, imgBusiness, btnClose, detailView, btnCall, btnDirection, btnShare;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    if ( section == 0 )
//        return [arr_featured_bussines count] + 1 ;
//    else
        return [[GlobalVariable sharedInstance].table_google count] ;
        //return 60 ;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"UITableViewCell";
    NLCachedImageTableViewCell *cell = (NLCachedImageTableViewCell*) [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell)
    {
        cell = [[NLCachedImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        if (IDIOM == IPAD)
            cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
        else
            cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        
        for (UIView *tempView in cell.contentView.subviews)
             [tempView removeFromSuperview] ;
    }
    
//    if ( indexPath.section == 0 )
//    {
//        if ( indexPath.row > 0 )
//        {
//            [cell setImageUrlString:[[arr_featured_bussines objectAtIndex:indexPath.row-1] valueForKey:@"icon"]];
//            cell.textLabel.text = [[arr_featured_bussines objectAtIndex:indexPath.row-1] valueForKey:@"name"] ;
//            cell.detailTextLabel.text = [[arr_featured_bussines objectAtIndex:indexPath.row-1] valueForKey:@"address"] ;
//            
//        }
//        else
//        {
//            cell.textLabel.text = @"Place your Ad" ;
//            cell.detailTextLabel.text = @"Add your business on this spot" ;
//            [cell setImageUrlString:@""];
//            
//        }
//        
//    }
//    else if ( indexPath.section == 1 )
//    {
        [cell setImageUrlString:nil];
        
        if ( [[GlobalVariable sharedInstance].table_google count] > indexPath.row )
        {
            cell.textLabel.text = [[[GlobalVariable sharedInstance].table_google objectAtIndex:indexPath.row] valueForKey:@"name"] ;
            cell.detailTextLabel.text = [[[GlobalVariable sharedInstance].table_google objectAtIndex:indexPath.row] valueForKey:@"title"] ;
        }
    //}
    
    if ( indexPath.row % 2 == 0 )
        cell.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0] ;
    else
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] ;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if ( section == 0 )
//        return 45;
//    else
        return 20 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( IDIOM == IPAD )
        return 70 ;
    else
        return 60 ;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
//    if ( indexPath.section == 0 )
//    {
//        if ( indexPath.row == 0 )
//        {
//            [self performSegueWithIdentifier:@"placeAddNewBussiness" sender:self] ;
//        }
//        else
//        {
//            nSelected_row = (int)indexPath.row - 1 ;
//            place_phone = [[[GlobalVariable sharedInstance].resPositions objectAtIndex:(indexPath.row - 1) ] valueForKey:@"call_num"] ;
//            
//            if ( [place_phone length] < 1 )
//                [btnCall setEnabled:NO] ;
//            else
//                [btnCall setEnabled:YES] ;
//            
//            f_FeaturedPlace = YES ;
//            [self showDetailView:(int)indexPath.row - 1] ;
//        }
//    }
//    else if ( indexPath.section == 1 )
    {
            
        nSelected_row = (int)indexPath.row ;
        place_phone = [[[GlobalVariable sharedInstance].table_google objectAtIndex:indexPath.row] valueForKey:@"call_num"] ;
        
        if ( [place_phone length] < 1 )
            [btnCall setEnabled:NO] ;
        else
            [btnCall setEnabled:YES] ;
        
        [self showDetailView:(int)indexPath.row] ;
        
    }
}

- (void)showDetailView:(int)nIndex
{
    if ( [[GlobalVariable sharedInstance].table_google count] > nIndex )
    {
        NSMutableArray* table_infos = [GlobalVariable sharedInstance].table_google;
        NSDictionary * data = [table_infos objectAtIndex:nIndex];
        if ( [[data valueForKey:@"name"] length] > 1 )
            [label_BizName setText:[data valueForKey:@"name"]] ;
        if ( IDIOM == IPAD )
            [txt_Description setFont:[UIFont systemFontOfSize:20]] ;
        
        if ([[data valueForKey:@"description"] length] > 0)
            [txt_Description setText:[data valueForKey:@"description"]] ;
        
        if ( [[data valueForKey:@"kind"] length] > 0 ) {
            NSString *type = [data valueForKey:@"kind"];
            if ([type isEqualToString:NSLocalizedString(@"Beauty & Health", @"Beauty & Health")]) {
                [imgBusiness setImage:[UIImage imageNamed:@"salon-iconlist"]];
            }else if([type isEqualToString:NSLocalizedString(@"Boutique", @"Boutique")]){
                [imgBusiness setImage:[UIImage imageNamed:@"boutique-listicon"]];
            }else if([type isEqualToString:NSLocalizedString(@"Attraction", @"Attraction")]){
                [imgBusiness setImage:[UIImage imageNamed:@"attraction-iconlist"]];
            }else if([type isEqualToString:NSLocalizedString(@"Restaurant", @"Restaurant")]){
                [imgBusiness setImage:[UIImage imageNamed:@"resto-listicon"]];
            }
        }
        
        link = [data valueForKey:@"link"];
        storename = [data valueForKey:@"name"];
        
        shareData = @"";
        [shareData stringByAppendingString:[data valueForKey:@"name"]];
        [shareData stringByAppendingString:@"\n"];
        [shareData stringByAppendingString:[data valueForKey:@"title"]];
        [shareData stringByAppendingString:@"\n"];
        [shareData stringByAppendingString:[data valueForKey:@"description"]];
        [shareData stringByAppendingString:@"\nAddress:"];
        [shareData stringByAppendingString:[data valueForKey:@"lat"]];
        [shareData stringByAppendingString:@"\n,"];
        [shareData stringByAppendingString:[data valueForKey:@"lng"]];
        [shareData stringByAppendingString:@"\nContact:"];
        [shareData stringByAppendingString:[data valueForKey:@"call_num"]];
        [shareData stringByAppendingString:@"\nLink:"];
        [shareData stringByAppendingString:[data valueForKey:@"link"]];
        
        if ( [[[table_infos objectAtIndex:nIndex] valueForKey:@"imagename"] length] > 1 ) {
            NSString * imageurl = self.baseimageurl;
            imageurl = [ imageurl stringByAppendingString:[[table_infos objectAtIndex:nIndex] valueForKey:@"imagename"] ];
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageurl]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageWithData:imageData];
                    [imgPromotion setImage:image] ;
                });
            });
            
        }
    }
    
    [UIView beginAnimations:nil context:NULL] ;
    [UIView setAnimationDuration:0.5] ;
    [detailView setAlpha:1.0] ;
    [self.mtable setAlpha:0.3] ;
    [self.view bringSubviewToFront:detailView] ;
    [UIView commitAnimations];
}

- (IBAction)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)onCloseDetail:(id)sender
{
    [UIView beginAnimations:nil context:NULL] ;
    [UIView setAnimationDuration:0.5] ;
    [detailView setAlpha:0.0] ;
    [self.mtable setAlpha:1.0] ;
    [self.view bringSubviewToFront:detailView] ;
    [UIView commitAnimations];
}

- (IBAction)onShare:(id)sender
{
    NSURL* url = [[NSURL alloc] initWithString:@"http://ixplorecanada.canadaworldapps.com"] ;
    
    NHCalendarEvent *calendarEvent = [self createCalendarEvent];
    NHCalendarActivity *calendarActivity = [[NHCalendarActivity alloc] init];
    calendarActivity.delegate = self;
    
    NSArray *activities = @[calendarActivity];
    
    self.activity = [[UIActivityViewController alloc] initWithActivityItems:@[shareData, url, calendarEvent]
                                                      applicationActivities:activities];
    
    self.activity.excludedActivityTypes = @[
                                            UIActivityTypePostToWeibo,
                                            UIActivityTypePrint,
                                            UIActivityTypeSaveToCameraRoll,
                                            UIActivityTypeAssignToContact
                                            ];
    
    [self presentViewController:self.activity
                       animated:YES
                     completion:NULL];
}

-(NHCalendarEvent *)createCalendarEvent
{
    NHCalendarEvent *calendarEvent = [[NHCalendarEvent alloc] init];
    
    calendarEvent.title = @"Long-expected Party";
    calendarEvent.location = @"The Shire";
    calendarEvent.notes = @"Bilbo's eleventy-first birthday.";
    calendarEvent.startDate = [NSDate dateWithTimeIntervalSinceNow:3600];
    calendarEvent.endDate = [NSDate dateWithTimeInterval:3600 sinceDate:calendarEvent.startDate];
    calendarEvent.allDay = NO;
    calendarEvent.URL = [NSURL URLWithString:@"http://github.com/otaviocc/NHCalendarActivity"];
    
    // Add alarm
    NSArray *alarms = @[
                        [EKAlarm alarmWithRelativeOffset:- 60.0f * 60.0f * 24],  // 1 day before
                        [EKAlarm alarmWithRelativeOffset:- 60.0f * 15.0f]        // 15 minutes before
                        ];
    calendarEvent.alarms = alarms;
    
    return calendarEvent;
}

#pragma mark - NHCalendarActivityDelegate

-(void)calendarActivityDidFinish:(NHCalendarEvent *)event
{
    NSLog(@"Event created from %@ to %@", event.startDate, event.endDate);
}

-(void)calendarActivityDidFail:(NHCalendarEvent *)event
                     withError:(NSError *)error
{
    NSLog(@"Ops!");
}

- (IBAction)onCall:(id)sender
{
    NSString* callStr = @"tel://" ;
    
    if ( [place_phone length] > 0 )
    {
        NSString* temp = @"" ;
        
        for ( int i = 0 ; i < place_phone.length ; i++ )
        {
            int n = [[place_phone substringWithRange:NSMakeRange(i, 1)] intValue] ;
            if ( n > 0 && n < 10 )
            {
                temp = [temp stringByAppendingString:[place_phone substringWithRange:NSMakeRange(i, 1)]] ;
            }
            else
            {
                NSString* temp1 = [place_phone substringWithRange:NSMakeRange(i, 1)] ;
                if ([temp1 isEqualToString:@"0"])
                    temp = [temp stringByAppendingString:@"0"] ;
            }
        }
        
        callStr = [callStr stringByAppendingString:temp] ;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callStr]];
}

- (IBAction)onMap:(id)sender
{
    [self.delegate onGotoStore:storename link:link];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [detailView setAlpha:0.0f] ;
    
    [self.mtable setDataSource:self] ;
    [self.mtable setDelegate:self] ;
    
    [btnClose setContentEdgeInsets:UIEdgeInsetsMake(-20, -20, -20, -20)] ;
    self.mtable.contentInset = UIEdgeInsetsMake(0, 0, 120, 0); //values passed are - top, left, bottom, right
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reload:) userInfo:nil repeats:YES];
}


-(void)reload:(NSTimer *)pTmpTimer
{
    intTmp += 1;
    
    if(intTmp <= 3)
    {
        
    }
    else
    {
        //[pTmpTimer invalidate];
        [_mtable reloadData] ;
        intTmp = 0;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    btnCall.layer.borderWidth = 1;
    btnCall.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    btnDirection.layer.borderWidth = 1;
    btnDirection.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    btnShare.layer.borderWidth = 1;
    btnShare.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //HUD = [[MBProgressHUD alloc] initWithView:self.view] ;
    //[self.view addSubview:HUD] ;
    //[HUD show:YES] ;
    
    //arr_google_bussines = [[NSMutableArray alloc] init] ;
    //[self LoadGooglePositions] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
