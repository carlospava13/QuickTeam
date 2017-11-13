//
//  MainVC.swift
//  QuickTeam
//
//  Created by Carlos Pava on 12/11/17.
//  Copyright © 2017 Carlos Pava. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
class MainVC: UIViewController {
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var labNameProfile: UILabel!
    
    deinit {
        print("deinitialed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.readField()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readField(){
        let parameters = ["fields":"name,first_name,picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) in
            if error != nil{
                print(error)
                return
            }
            let dict = result as! NSDictionary
            let picture = dict["picture"] as! NSDictionary
            let data = picture["data"] as! NSDictionary
            let url = data["url"] as! String
           self.setInfoToView(name: dict["name"] as! String, url: url)
            
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
    
    func setInfoToView(name:String,url:String){
         self.labNameProfile.text = name
        self.imgProfile.imageFromServerURL(urlString: url)
    }
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}
