//
//  LoginVC.swift
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
class LoginVC: UIViewController {
    
    deinit {
        print("deinitialed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
            case .success(_ ,_ ,_):
                self.showMain()
            }
        }
    }
    
    func showMain(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       unowned let vc = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.present(vc, animated: true, completion: nil)
    }
    
}
