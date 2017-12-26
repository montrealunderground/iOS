#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "GlobalVariable.h"

@interface ARView : UIView  <CLLocationManagerDelegate> {
}

@property (nonatomic, retain) NSArray *placesOfInterest;
@property (retain, nonatomic) UIView *captureView;
- (void)start;
- (void)stop;

@end
