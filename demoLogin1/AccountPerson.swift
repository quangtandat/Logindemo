//
//  AccountPerson.swift
//  demoLogin1
//
//  Created by Quang Dat on 4/21/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit
import RealmSwift
class AccountPerson: Object {
    dynamic var username = ""
    dynamic var password = ""
    dynamic var descriptionString = ""
    dynamic var age:Int = 0
    dynamic var dateOfBirth = ""
    dynamic var address = ""
   
    
    func addAccount(username:String, password: String, description:String){
        let person = AccountPerson()
        person.username = username
        person.password = password
        person.descriptionString = description
        let realm = try! Realm()
        try! realm.write {
             realm.add(person)
        }
    }
    func querryData()-> [[String:String]]{
        var arrayOfAccount = [[String:String]]()
        var dicAccount = [String:String]()
        let realm = try! Realm()
        let allAccount = realm.objects(AccountPerson)
        for account in allAccount{
                dicAccount["username"] = account.username
                dicAccount["password"] = account.password
                dicAccount["description"] = account.descriptionString
                arrayOfAccount.append(dicAccount)
            }
       // print(dicAccount)
        return arrayOfAccount
        }
    func addAccountDefault(){
        let person = AccountPerson()
        person.username = "abc"
        person.password = "123"
        person.descriptionString = "abc"
        let realm = try! Realm()
        try! realm.write {
            realm.add(person)
        }
    }


}
