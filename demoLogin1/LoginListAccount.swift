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
        leftBarButton = UIBarButtonItem.init(title: "Back", style: .plain, target: self, action: #selector(self.backAccountListAction))
        self.navigationItem.leftBarButtonItem = leftBarButton
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        userArray   = Array(AppDelegate.dicAccount.keys)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func addNewAccountAction(){
         didTapRegister?(true)
        let _ = self.navigationController?.popViewController(animated: true)
        //isRegister = true
        
    }
    func backAccountListAction(){
        didTapRegister?(false)
        let _ = self.navigationController?.popViewController(animated: true)
        //isRegister = false
    }
    
}
extension LoginListAccount:UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = userArray[indexPath.row]
        return cell!
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return userArray.count
        
    }
    
}



