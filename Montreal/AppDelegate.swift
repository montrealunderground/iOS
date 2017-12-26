//
//  AppDelegate.swift
//  Montreal
//
//  Created by William Andersson on 3/6/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import UIKit
import UserNotifications
import Proximiio
import Firebase
import FirebaseMessaging
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, ProximiioDelegate, FIRMessagingDelegate {

    let gcmMessageIDKey = "gcm.message_id"
    
    var window: UIWindow?
    var profileVC : ProfileViewController = ProfileViewController()
    var homeVC : HomeViewController = HomeViewController()
    var undergroundVC : UndergroundViewController = UndergroundViewController()
    var arVC : ARListViewController = ARListViewController()
    var imagemapVC : ImageMapViewController = ImageMapViewController()
    var metroVC : MetroPlanViewController = MetroPlanViewController()
    var eventVC : EventViewController = EventViewController()
    var eventdetailVC : EventDetailViewController = EventDetailViewController()
    var promotionVC : PromotionViewController = PromotionViewController()
    var ucstoreVC : UCStoreViewController = UCStoreViewController()
    var facebookVC : FacebookViewController = FacebookViewController()
    var feedbackVC : FeedbackViewController = FeedbackViewController()
    var contactVC : ContactViewController = ContactViewController()
    var shareVC : ShareViewController = ShareViewController()
    var shoppingVC : ShoppingViewController = ShoppingViewController()
    var placesVC : PlacesViewController = PlacesViewController()
    var jobsVC : JobsViewController = JobsViewController()
    var hotelsVC : HotelsViewController = HotelsViewController()
    
    var searchVC : SearchViewController = SearchViewController()
    
    var currentVC : UIViewController? = nil
    
    var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    var interstitialAdsState: NSMutableDictionary = [:]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        Twitter.sharedInstance().start(withConsumerKey:"Cwt8M5ymkKqs3P1mmQVwvEv9t", consumerSecret:"M14gpWcWD1dwD0je8iD6007LlKJhMtdbewt5CzzjbIBO0JPts4")
        // Fabric.with([Twitter.self])
        
        //google signin
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")

        //initialize google ads
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: NSLocalizedString(Constants.AWARDED_VIDEO_ADS_UNIT_ID, comment: "Awarded Video Ads Unit ID"))
//        GADMobileAds.configure(withApplicationID: NSLocalizedString(Constants.AWARDED_VIDEO_ADS_UNIT_ID, comment: "Awarded Video Ads Unit ID"))
        
        // Override point for customization after application launch.
        let backButtonImage = UIImage(named: "back_btn")
        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        
        UINavigationBar.appearance().tintColor = UIColor.darkGray
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-500, -100), for: .default )
        
        registerForPushNotifications(application: application)
        initProximiio()
        
        initializeViewController()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: .firInstanceIDTokenRefresh,
                                               object: nil)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        let fbhandled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        let gidhandled = GIDSignIn.sharedInstance().handle(url as URL!,
                                             sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                             annotation: options[UIApplicationOpenURLOptionsKey.annotation])

        let gpphandled = GPPURLHandler.handle(url as URL!,
                                              sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                              annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        return fbhandled
    }
    
    
    func registerForPushNotifications(application: UIApplication) {
        if #available(iOS 10, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self;
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in
                if error == nil {
                    application.registerForRemoteNotifications()
                }
            }
            
            FIRMessaging.messaging().remoteMessageDelegate = self
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
    }
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        
        //FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.unknown)
        NetworkManger.sharedInstance.sendDeviceTokenRegisterRequest(parameters: ["devicetoken" : deviceTokenString, "devicetype" : "iOS" ]) { (json, status) in
            print(json)
        }
        // Persist it in your backend in case it's new
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        print("didReceiveRemoteNotification1")
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // Print full message.
        print("didReceiveRemoteNotificatio2")
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }

    
    // [START refresh_token]
    func tokenRefreshNotification(_ notification: Notification) {
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
        }
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    // [END refresh_token]
    
    // [START connect_to_fcm]
    func connectToFcm() {
        // Won't connect since there is no token
        guard FIRInstanceID.instanceID().token() != nil else {
            return
        }
        
        // Disconnect previous FCM connection if it exists.
        FIRMessaging.messaging().disconnect()
        
        FIRMessaging.messaging().connect { (error) in
            if error != nil {
                print("Unable to connect with FCM. \(error?.localizedDescription ?? "")")
            } else {
                print("Connected to FCM.")
            }
        }
    }
    // [END connect_to_fcm]
    
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("Montreal Underground City", comment:"appname")
        content.body = (remoteMessage.appData["notification"] as! NSDictionary)["body"] as! String
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
        let center  = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: { (error) in
            print("completed")
        })

        print("applicationReceivedRemoteMessage")
        print(remoteMessage.appData)
    }
    
    // [START connect_on_active]
    func applicationDidBecomeActive(_ application: UIApplication) {
        connectToFcm()
        FBSDKAppEvents.activateApp()
    }
    // [END connect_on_active]
    
    // [START disconnect_from_fcm]
    func applicationDidEnterBackground(_ application: UIApplication) {
        FIRMessaging.messaging().disconnect()
        print("Disconnected from FCM.")
    }
    // [END disconnect_from_fcm]
    
    //Called when a notification is delivered to a foreground app.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print("User Info = ", notification.request.content.userInfo)
        completionHandler([.alert, .badge, .sound])
    }
    
    //Called to let your app know which action was selected by the user for a given notification.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
        
    }
    
    func proximiioHandlePushMessage(_ title: String!) -> Bool {
        
        print("proximiioHandlePushMessage", title)
        return false
        
    }
    
    func proximiioPositionUpdated(_ location: ProximiioLocation!) {
        print("proximiioPositionUpdated", location)
    }
    
    func initProximiio() {
        let token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImlzcyI6IjZhODFkMGM5LTA2YTYtNDc3OC04YTBkLTY5ZjBiODNlMDk2MiIsInR5cGUiOiJhcHBsaWNhdGlvbiIsImFwcGxpY2F0aW9uX2lkIjoiMDU5OWM4YWMtZDUyMS00ZWI0LWJjNzItY2Y0YTc3MDA5NjMyIn0.qzb2LXtroi8BcapqF4UmGGSGb1x-ENzfE0CCSHDcnRk"
        
        let proximiio = Proximiio.sharedInstance() as! ProximiioManager
        proximiio.delegate = self
        
        proximiio.auth(withToken: token) { (state : ProximiioState) in
            if (state == kProximiioReady) {
                proximiio.requestPermissions()
                NSLog("Proximi.io ready")
            } else {
                NSLog("Proximi.io auth failure")
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

//    func applicationDidEnterBackground(_ application: UIApplication) {
//        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func initializeViewController() {
        NetworkManger.sharedInstance.getInterstitialAdsAPI() { (json, status) in
            print(json)
            let state:NSArray = json["interstitialads"] as! NSArray
            let cnt = state.count
            var i:Int
            self.interstitialAdsState.removeAllObjects()
            for i in 0..<(cnt-1) {
                let row:NSDictionary = state[i] as! NSDictionary
                self.interstitialAdsState.addEntries(from: [(row["screenname"] as! String): (row["value"] as! String)])
            }
        }
        
        profileVC = self.storyboard.instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        
        homeVC = self.storyboard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
        
        undergroundVC = self.storyboard.instantiateViewController(withIdentifier: "undergroundViewController") as! UndergroundViewController
        
        arVC = self.storyboard.instantiateViewController(withIdentifier: "arListViewController") as! ARListViewController
        
        imagemapVC = self.storyboard.instantiateViewController(withIdentifier: "imageMapViewController") as! ImageMapViewController
        
        metroVC = self.storyboard.instantiateViewController(withIdentifier: "metroViewController") as! MetroPlanViewController
        
        eventVC = self.storyboard.instantiateViewController(withIdentifier: "eventViewController") as! EventViewController
        
        eventdetailVC = self.storyboard.instantiateViewController(withIdentifier: "eventDetailViewController") as! EventDetailViewController
        
        promotionVC = self.storyboard.instantiateViewController(withIdentifier: "promotionViewController") as! PromotionViewController
        
        ucstoreVC = self.storyboard.instantiateViewController(withIdentifier: "ucitemStoreViewController") as! UCStoreViewController
        
        facebookVC = self.storyboard.instantiateViewController(withIdentifier: "facebookViewController") as! FacebookViewController
        
        feedbackVC = self.storyboard.instantiateViewController(withIdentifier: "feedbackViewController") as! FeedbackViewController
        
        contactVC = self.storyboard.instantiateViewController(withIdentifier: "contactViewController") as! ContactViewController
        
        shareVC = self.storyboard.instantiateViewController(withIdentifier: "shareViewController") as! ShareViewController
        
        shoppingVC = self.storyboard.instantiateViewController(withIdentifier: "shoppingViewController") as! ShoppingViewController
        
        placesVC = self.storyboard.instantiateViewController(withIdentifier: "placesViewController") as! PlacesViewController
        
        jobsVC = self.storyboard.instantiateViewController(withIdentifier: "jobsViewController") as! JobsViewController
        
        hotelsVC = self.storyboard.instantiateViewController(withIdentifier: "hotelsViewController") as! HotelsViewController
        
        searchVC = self.storyboard.instantiateViewController(withIdentifier: "searchViewController") as! SearchViewController
    }
    
    public func onOpenVC(vc: UIViewController) {
        currentVC = vc
    }
}

