//
//  ViewController.swift
//  Project_Chefsy
//
//  Created by XongoLab on 12/10/18.
//  Copyright © 2018 XongoLab. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookCore
//import Firebase
//import GoogleSignIn

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var ScrlView: UIScrollView!
    
    @IBOutlet weak var BtnGoogle: UIControl!
    @IBOutlet weak var BtnFacebook: UIControl!
    @IBOutlet weak var BtnContinue: UIButton!
    @IBOutlet weak var TxtUsername: UITextField!
    @IBOutlet weak var TxtEmail: UITextField!
    @IBOutlet weak var TxtContactNumber: UITextField!
    @IBOutlet weak var TxtPassword: UITextField!
    @IBOutlet weak var BtnShowPassword: UIButton!
    
    var users:String?
    var Emails:String?
    var Mobiles:String?
    var Pass:String?
    var dictionaries = [String:Any]()
   
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TxtUsername.text = users
        TxtEmail.text = Emails
        TxtContactNumber.text = Mobiles
        TxtPassword.text = Pass
      
        //MARKS:-- ScrollView
        ScrlView.contentSize = CGSize(width:self.view.frame.size.width, height:667)
        
        //MARKS:- Button Constrain
        BtnFacebook.layer.cornerRadius = 20
        BtnFacebook.layer.borderWidth = 1
        BtnFacebook.layer.borderColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1).cgColor
        
        BtnGoogle.layer.cornerRadius = 20
        BtnGoogle.layer.borderWidth = 1
        BtnGoogle.layer.borderColor = UIColor.red.cgColor
    
        BtnContinue.layer.cornerRadius = 25
        BtnContinue.layer.borderWidth = 1
        BtnContinue.layer.borderColor = UIColor.red.cgColor
        BtnContinue.backgroundColor = .clear
    
        textfieldlayout()
        //forFB()
    }
        func textfieldlayout(){
        TxtUsername.leftViewMode = UITextFieldViewMode.always
        //let paddding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "user")
        imageView.image = image
        TxtUsername.leftView = imageView
        

        TxtEmail.leftViewMode = UITextFieldViewMode.always
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image1 = UIImage(named: "email")
        imageView1.image = image1
        TxtEmail.leftView = imageView1
 

        TxtPassword.leftViewMode = UITextFieldViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image2 = UIImage(named: "password")
        imageView2.image = image2
        TxtPassword.leftView = imageView2


        TxtContactNumber.leftViewMode = UITextFieldViewMode.always
        let imageView3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image3 = UIImage(named: "number")
        imageView3.image = image3
        TxtContactNumber.leftView = imageView3
    }
    
    @IBAction func BtnFacebook(_ sender: UIControl){
//        if (FBSDKAccessToken.currentAccessTokenIsActive() != nil)
//        {
//            // User is already logged in, do work such as go to next view controller.
//            print("already logged in ")
//            self.getFBUserData()
//            print(getFBUserData())
//            return
//        }
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email"], from: self){ (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error != nil){
                    
                    print(error?.localizedDescription)
                }else{
                    print(result as! NSDictionary)
                    
                    self.dictionaries = result as! [String : Any]
                    
                    print(self.dictionaries)
                    self.TxtUsername.text = self.dictionaries["name"] as! String?
                    self.TxtEmail.text = self.dictionaries["email"] as! String?

                }
            })
        }
}

    @IBAction func BtnShowLogin(_ sender: UIControl) {
}
    
    @IBAction func BtnShowPass(_ sender: UIButton) {
        if(iconClick == true) {
            TxtPassword.isSecureTextEntry = false
        } else {
            TxtPassword.isSecureTextEntry = true
        }
        
        iconClick = !iconClick
    }
    

    @IBAction func BtnCOntinue(_ sender: UIButton) {
        let NextVC:SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(NextVC, animated: true)
        
        //print("show continue")
    }
    
    
    //MARKS:-- For g+ Login integration in App
   
    
}


