//
//  ProximiioMapView.h
//  LeafletTest
//
//  Created by Matej Držík on 22/09/16.
//  Copyright © 2016 Proximi.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Proximiio.h"

@interface ProximiioMapView : UIView

- (void)setCurrentLocation:(CLLocation *)location title:(NSString *)title;
- (void)addMarker:(CLLocation *)location html:(NSString *)html options:(NSDictionary *)options;
- (void)addIcon:(NSDictionary *)options;

- (void)addCircle:(NSString *)identifier
         location:(CLLocation *)location
           radius:(int)radius
            color:(NSString *)color
        fillColor:(NSString *)fillColor
          opacity:(float)opacity
            title:(NSString *)title;

- (void)addFloorPlan:(ProximiioFloor *)floor;
- (void)setLocationTracking:(BOOL)enabled;
- (void)setDestination:(CLLocation *)location;
- (void)setView:(CLLocation *)location;
- (void)setView:(CLLocation *)location zoom:(int)zoom;
- (void)runCommand:(NSString *)command;
- (void)rlog:(NSString *)message;
- (id)initWithFrame:(CGRect)frame delegate:(id)delegate;

@property (weak) id delegate;
@property (nonatomic, strong) WKWebView *webView;

@end

@protocol ProximiioMapViewDelegate

@optional
- (void)mapView:(ProximiioMapView *)mapView onPlatformReady:(NSString *)message;

@end
