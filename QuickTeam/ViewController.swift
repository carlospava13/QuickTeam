//
//  ViewController.swift
//  QuickTeam
//
//  Created by Carlos Pava on 12/11/17.
//  Copyright © 2017 Carlos Pava. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit
class ViewController: UIViewController {
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
   
        if let token = FBSDKAccessToken.current(){
            print(token.appID)
            self.readField()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    @IBAction func onLogin(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile,.email,.userFriends,.readCustomFriendlists], viewController: self) { (loginResult) in
            switch loginResult{
            case .failed(let error):
                print(error)
            case .cancelled:
                print("cancel")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("\n se logueo \n")
                 self.readField()
            }
        }
    }
    
    func readField(){
        let parameters = ["fields":"first_name,picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) in
            if error != nil{
                print(error)
                return
            }
            print(result)
            self.showFriends()
        }
    }
    
    func showFriends(){
        let parameters = ["fields":"name,picture.type(normal),gender"]
        FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: parameters).start { (connection, result, error) in
            if error != nil{
                print(error)
                return
            }
            print(result)
        }
    }

}

