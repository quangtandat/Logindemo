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
    var flagRegister = false
    var keyboardHeight:CGFloat? {
        didSet {
            if let keyboardHeight = keyboardHeight {
                outletConstraint.constant = keyboardHeight
                
            }
        }
    }
    
    @IBOutlet weak var constrantHeightTextView: NSLayoutConstraint!
    
    @IBOutlet weak var constrantTxtUserNameWithButton: NSLayoutConstraint!
    @IBOutlet weak var txtViewDescription: UITextView!
    
    @IBOutlet weak var btnLoginOutlet: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outletConstraint: NSLayoutConstraint!
    @IBAction func btnTap(_ sender: AnyObject) {
        let username = txtUserName.text
        let password = txtPassword.text
        var description = txtViewDescription.text
        if description == "Your text here"
        {
            description = ""
        }
        // seperate string to array
      var arrayOfString = description?.components(separatedBy: CharacterSet.newlines)
        arrayOfString = arrayOfString?.filter{$0 != ""}
        let joiner = "\n"
      
        let joinedStrings = arrayOfString?.joined(separator: joiner)
        
        
        
        if btnLoginOutlet.titleLabel?.text! == "Register" {
            self.view.endEditing(true)
            if username != "" && password != ""{
                for pointer in AppDelegate.dicAccountArray{
                    if username == pointer["username"] {
                        flagRegister = true
                    }
                    
                }
                if (flagRegister){
                    let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                    })
                    alert.showAlert("Alert", message:"Username already exists", actions:[actionOK])
                    flagRegister = false
                }
                else{
                    AppDelegate.dicAccountArray.append(["username":username!,"password":password!,"description":joinedStrings!])
                    print(AppDelegate.dicAccountArray)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginListAccount") as! LoginListAccount
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.didTapRegister = {(isRegister) -> () in
                        self.setupUIForRegisterState(isRegister)
                       
                    }
                    
                }
            }
            else{
                let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                })
                alert.showAlert("Alert", message:"username and password empty", actions:[actionOK])
            }
        }
        else{
            
            // condition username and password is not empty
            if username != "" && password != ""{ //
                //loop all dictionary to find username and password
                for pointer in AppDelegate.dicAccountArray{
                    if username == pointer["username"] && password == pointer["password"]
                    {
                        flag = true
                    }
                    
                    //AppDelegate.dicAccountArray.append(a)
                }
                // check if dictionary have username and password
                if flag == true{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginListAccount") as! LoginListAccount
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.didTapRegister = {(isRegister) -> () in
                        self.setupUIForRegisterState(isRegister)
                        self.view.endEditing(true)
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
        
        // txtUserName.returnKeyType = .next
        txtUserName.delegate = self
        // txtPassword.returnKeyType = .next
        // txtViewDescription.returnKeyType = .done
        txtViewDescription.delegate = self
        txtPassword.delegate = self
        //observer when keyboard did show
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        txtUserName.tag = 0
        txtPassword.tag = 1
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.endEditing(true)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUIForRegisterState(_ isRegister: Bool) {
        if isRegister {
            txtUserName.returnKeyType = .next
            txtPassword.returnKeyType = .next
            txtViewDescription.returnKeyType = .done
            btnLoginOutlet.setTitle("Register", for: .normal)
            txtPassword.text = ""
            txtUserName.text = ""
            txtViewDescription.text = "Your text here"
            txtViewDescription.textColor = UIColor.lightGray

            flag = false
            if  txtViewDescription.isHidden == true{
                txtViewDescription.isHidden = false
                constrantTxtUserNameWithButton.constant =  constrantTxtUserNameWithButton.constant + constrantHeightTextView.constant
            }
        }
        else {
            txtUserName.returnKeyType = .next
            txtPassword.returnKeyType = .done
            
            btnLoginOutlet.setTitle("Login", for: .normal)
            txtPassword.text = ""
            txtUserName.text = ""
        
            //txtViewDescription.endEditing(true)
            flag = false
            if  txtViewDescription.isHidden == false{
                txtViewDescription.isHidden = true
                constrantTxtUserNameWithButton.constant =  constrantTxtUserNameWithButton.constant - constrantHeightTextView.constant
            }
            self.view.endEditing(true)
            self.view.resignFirstResponder()
            
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
            if (txtPassword.isFirstResponder){
                let heightScrolltxtPassword = keyboardHeight! - txtPassword.frame.maxY
                if heightScrolltxtPassword<0{
                    scrollView.setContentOffset(CGPoint(x: 0, y: txtPassword.frame.maxY - keyboardHeight!), animated: true)
                }
            }
            else if (txtViewDescription.isFirstResponder){
                let heightScrolltxtViewDescription = keyboardHeight! - txtViewDescription.frame.minY
                if heightScrolltxtViewDescription<0{
                    scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
                    
                }
            }
        }
    }
    
}
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let username = txtUserName.text
        let password = txtPassword.text
        let description = txtViewDescription.text
        if btnLoginOutlet.titleLabel?.text! == "Register" {
            if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            }
            else{
                 textField.resignFirstResponder()
                }
        }
            
            
        else{
            
            if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            } else {
                if username != "" && password != ""{ //
                    //loop all dictionary to find username and password
                    for pointer in AppDelegate.dicAccountArray{
                        if username == pointer["username"] && password == pointer["password"]
                        {
                            flag = true
                        }
                        
                        //AppDelegate.dicAccountArray.append(a)
                    }
                    // check if dictionary have username and password
                    if flag == true{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginListAccount") as! LoginListAccount
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.didTapRegister = {(isRegister) -> () in
                            self.setupUIForRegisterState(isRegister)
                            self.view.endEditing(true)
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

                textField.resignFirstResponder()
            }
    
    
    
        return true
}
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        outletConstraint.constant = 10
    }
}
extension LoginViewController: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        outletConstraint.constant = 10
        if txtViewDescription.text.isEmpty {
            txtViewDescription.text = "Your text here"
            txtViewDescription.textColor = UIColor.lightGray
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtViewDescription.textColor == UIColor.lightGray {
            txtViewDescription.text = nil
            txtViewDescription.textColor = UIColor.black
        }
    }
    // limit character in textview < 300 character
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 300;
    }

    
}
