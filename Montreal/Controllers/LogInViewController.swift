//
//  LogInController.swift
//  Montreal
//
//  Created by William Andersson on 4/21/17.
//  Copyright © 2017 William Andersson. All rights reserved.
//

import UIKit
import KVSpinnerView

public class LogInViewController:UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var gpLoginButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let currentToken = FBSDKAccessToken.current()
        KVSpinnerView.settings.backgroundRectColor = UIColor.darkGray
        if (currentToken != nil) {
            self.showPrgressBar(saying: NSLocalizedString("SIGNING IN FACEBOOK", comment:"facebook"), visibility:true)
            //KVSpinnerView.show(on: self.view, saying:NSLocalizedString("SIGNING IN FACEBOOK", comment:"facebook"))
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, middle_name, last_name, email, picture"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let fbDetails = result as! NSDictionary
                    let photourl = ((fbDetails["picture"] as! NSDictionary)["data"] as! NSDictionary)["url"] as! String
                    //                        let firstname:String? = fbDetails["first_name"] as! String
                    //                        let middlename:String? = fbDetails["middle_name"] as! String
                    //                        let lastname:String? = fbDetails["last_name"] as! String
                    //
                    //                        var name:String! = ""
                    //                        if (firstname != nil) {
                    //                            name = firstname
                    //                        }
                    //                        if (middlename != nil && middlename?.characters.count > 0) {
                    //                            name=
                    //                        }
                    
                    self.moveToMainScreenWithRegistration(name: fbDetails["name"] as! String, userid: fbDetails["id"] as! String, accessToken: FBSDKAccessToken.current().tokenString, photourl: photourl, isfb:true)
                    
                } else {
                    self.showPrgressBar(saying: NSLocalizedString("SIGNING IN FACEBOOK", comment:"facebook"), visibility:false)
                }
            })
        } else {
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
        
            if GIDSignIn.sharedInstance().hasAuthInKeychain() == true{
                self.showPrgressBar(saying: NSLocalizedString("SIGNING IN GOOGLE", comment:"google"), visibility:true)
                //KVSpinnerView.show(on: self.view, saying:NSLocalizedString("SIGNING IN GOOGLE", comment:"google"))
                GIDSignIn.sharedInstance().signInSilently()
            }
            else{
            }
        }
    }
    
    @IBAction func facebookLogInAction(_ sender: Any) {
        let login : FBSDKLoginManager = FBSDKLoginManager()
        //KVSpinnerView.show(on: self.view, saying:NSLocalizedString("SIGNING IN FACEBOOK", comment:"facebook"))
        self.showPrgressBar(saying: NSLocalizedString("SIGNING IN FACEBOOK", comment:"facebook"), visibility:true)
        login.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if ((error) != nil) {
                self.showPrgressBar(saying: NSLocalizedString("SIGNING IN FACEBOOK", comment:"facebook"), visibility:false)
            } else if (result?.isCancelled)! {
                self.showPrgressBar(saying: NSLocalizedString("SIGNING IN FACEBOOK", comment:"facebook"), visibility:false)
            } else {
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, middle_name, last_name, email, picture.width(512).height(512)"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        let fbDetails = result as! NSDictionary
                        let photourl = ((fbDetails["picture"] as! NSDictionary)["data"] as! NSDictionary)["url"] as! String
                        
                        self.moveToMainScreenWithRegistration(name: fbDetails["name"] as! String, userid: fbDetails["id"] as! String, accessToken: FBSDKAccessToken.current().tokenString, photourl: photourl, isfb:true)
                    }
                })
            }
        }
    }
    
    @IBAction func googleLogInAction(_ sender: Any) {
        self.showPrgressBar(saying: NSLocalizedString("SIGNING IN GOOGLE", comment:"google"), visibility:true)
        //KVSpinnerView.show(on: self.view, saying:NSLocalizedString("SIGNING IN GOOGLE", comment:"google"))
        GIDSignIn.sharedInstance().signIn()
    }
    
    //Google Sign-In
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {

    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //KVSpinnerView.show(on: self.view, saying:"Logging In With Google")
        
        var imageurl:String! = ""
        if (signIn.currentUser.profile.hasImage) {
            imageurl = signIn.currentUser.profile.imageURL(withDimension: 160).absoluteString
        } else {
            imageurl = "http://vortexapp.ca/montrealadmin/assets/img/avatar.png"
        }
        self.moveToMainScreenWithRegistration(
            name: signIn.currentUser.profile.name ,
            userid: signIn.currentUser.userID ,
            accessToken: signIn.currentUser.authentication.accessToken ,
            photourl: imageurl ,
            isfb: false)
    }
    
    public func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
    }
    
    // Present a view that prompts the user to sign in with Google
    public func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    public func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func moveToMainScreenWithRegistration(name:String!, userid:String!, accessToken:String!, photourl:String!, isfb:Bool!) {
        NetworkManger.sharedInstance.authenticateUser(name:name, userid:userid, accessToken:accessToken, photourl:photourl, isfb:isfb) { (json, status) in
            
            //KVSpinnerView.dismiss()
            
            print (json)
            if ((json["result"] as! String) != "success") {
                print("authentication Failed")
                return
            }
            
            Constants.profileUserId = json["userid"] as! String
            Constants.profileName = json["name"] as! String
            Constants.profileBalance = json["undercoin"] as! String
            Constants.profileImgUrl = json["pictureUrl"] as! String
            
            self.performSegue(withIdentifier: "HomeSegue", sender: self)
        }
    }
    
    public func showPrgressBar(saying: String!, visibility:Bool!) {
        if (visibility == true) {
            KVSpinnerView.show(on: self.view, saying:saying)
        } else {
            KVSpinnerView.dismiss()
        }
        fbLoginButton.isUserInteractionEnabled = !visibility
        gpLoginButton.isUserInteractionEnabled = !visibility
    }
}
