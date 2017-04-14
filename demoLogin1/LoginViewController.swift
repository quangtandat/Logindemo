//
//  LoginViewController.swift
//  demoLogin
//
//  Created by Quang Dat on 4/12/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnLoginOutlet: UIButton!
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
            if username != nil && password != nil{
                for (key,value) in AppDelegate.dicAccount{
                    if username == key && password == value{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginListAccount") as! LoginListAccount
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.didTapRegister = {(isRegister) -> () in
                            self.setupUIForRegisterState(isRegister)
                        }
                    }
                }
            }
        }
    }
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIForRegisterState(false)
        // Do any additional setup after loading the view.
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
          
        }
        else {
            btnLoginOutlet.setTitle("Login", for: .normal)
            txtPassword.text = ""
            txtUserName.text = ""
          
        }
    }
    
    
    
}
