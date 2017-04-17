//
//  LoginViewController.swift
//  demoLogin
//
//  Created by Quang Dat on 4/12/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var alert:AlertViewClass = AlertViewClass()
    var flag = false
    var keyboardHeight:CGFloat? {
        didSet {
            if let keyboardHeight = keyboardHeight {
                outletConstraint.constant = keyboardHeight
                
            }
        }
    }
    @IBOutlet weak var btnLoginOutlet: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outletConstraint: NSLayoutConstraint!
    @IBAction func btnTap(_ sender: AnyObject) {
        let username = txtUserName.text
        let password = txtPassword.text
        if btnLoginOutlet.titleLabel?.text! == "Register" {
            if username != nil && password != nil{
                AppDelegate.dicAccount[username!] = password
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginListAccount") as! LoginListAccount
                self.navigationController?.pushViewController(vc, animated: true)
                vc.didTapRegister = {(isRegister) -> () in
                    self.setupUIForRegisterState(isRegister)
                }
                print(AppDelegate.dicAccount)
            }
        }
        else{
            // condition username and password is not empty
            if username != "" && password != ""{ //
                //loop all dictionary to find username and password
                for (key,value) in AppDelegate.dicAccount{
                    if username == key && password == value{
                        flag = true
                    }
                }
                    // check if dictionary have username and password
                    if flag == true{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginListAccount") as! LoginListAccount
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.didTapRegister = {(isRegister) -> () in
                            self.setupUIForRegisterState(isRegister)
                        }
                    }
                        //if don't show alert
                    else{
                        let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                        })
                        alert.showAlert("Alert", message:"Password or username wrong", actions:[actionOK])
                    }
                }
            
                // condition username and password is empty
            else{
                let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                })
                alert.showAlert("Alert", message:"username and password empty", actions:[actionOK])
            }
        }
    }
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIForRegisterState(false)
        self.navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        // add tap gesture
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.isTap))
        self.view.addGestureRecognizer(tapGesture)
        
        txtUserName.returnKeyType = .done
        txtUserName.delegate = self
        txtPassword.returnKeyType = .done
        txtPassword.delegate = self
        //observer when keyboard did show
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUIForRegisterState(_ isRegister: Bool) {
        if isRegister {
            btnLoginOutlet.setTitle("Register", for: .normal)
            txtPassword.text = ""
            txtUserName.text = ""
            flag = false
            
        }
        else {
            btnLoginOutlet.setTitle("Login", for: .normal)
            txtPassword.text = ""
            txtUserName.text = ""
            flag = false
            
        }
    }
    //dimiss Keyboard
    func isTap(){
        self.view.endEditing(true)
        
    }
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
           // check if keyboard frame is higher than textfield frame if higher textfield will be pushed up
            let heightScroll = keyboardHeight! - txtPassword.frame.maxY
            if heightScroll<0{
                scrollView.setContentOffset(CGPoint(x: 0, y: txtPassword.frame.maxY - keyboardHeight!), animated: true)
            }
        }
    }
    
}
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        outletConstraint.constant = 10
    }
}
