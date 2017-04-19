//
//  LoginListAccount.swift
//  demoLogin
//
//  Created by Quang Dat on 4/12/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

//var isRegister = false
typealias didTapRegister = (_ _isRegister: Bool) -> ()

class LoginListAccount: UIViewController {
    var rightBarButton:UIBarButtonItem = UIBarButtonItem()
    var leftBarButton:UIBarButtonItem = UIBarButtonItem()
    var userArray:Array = [String]()
    var didTapRegister: didTapRegister?
 
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnAdd: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton = UIBarButtonItem.init(title: "Add", style: .plain, target: self, action: #selector(self.addNewAccountAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
        leftBarButton = UIBarButtonItem.init(title: "Log out", style: .plain, target: self, action: #selector(self.backAccountListAction))
        self.navigationItem.leftBarButtonItem = leftBarButton
        tableView.dataSource = self
         tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 103
       
    }
    override func viewWillAppear(_ animated: Bool) {
       // userArray   = Array(AppDelegate.dicAccountArray.keys)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func addNewAccountAction(){
         didTapRegister?(true)
        let _ = self.navigationController?.popViewController(animated: true)
       
        
    }
    func backAccountListAction(){
        didTapRegister?(false)
        let _ = self.navigationController?.popViewController(animated: true)
       
    }
    
}
extension LoginListAccount:UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LoginListAccountCell
        cell.lblAccount.text = AppDelegate.dicAccountArray[indexPath.row]["username"]
       cell.lblDescription.text = AppDelegate.dicAccountArray[indexPath.row]["description"]
       // cell.lblDescription.numberOfLines = 3
        return cell
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return AppDelegate.dicAccountArray.count
        
    }
   
    
    
}
extension LoginListAccount:UITableViewDelegate{
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
}

