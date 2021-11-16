//
//  ViewController.swift
//  FourSquareCloneApp
//
//  Created by burak ozen on 19.10.2021.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        
        
//        VERİ KAYDETME
        
        /*
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banana"
        parseObject["calories"] = 150
        parseObject.saveInBackground { success, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("uploaded")
            }
        }
        */
        
//        VERİ ÇEKME
        
        /*
        
//       Parse veritabanı içinde verileri kaydetmek için " PFObject " verileri çekmek için de " PFQuery "
        let query = PFQuery(className: "Fruits")
        
//        mesela sadece Apple ı çekmek isterseydik
//        query.whereKey("name", equalTo: "Apple")
        
//        calories i 120 den buyukleri getir demek istediğimizde
        query.whereKey("calories", greaterThan: 120)
        
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print(error?.localizedDescription)
                
            } else {
                print(objects)
            }
                
        }
        
        */
        
    }
    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
//                    segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Usernama / Password ?")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = userNameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!")
                } else {
                    
//                    segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                }
                
            }
            
        } else {
            
            makeAlert(titleInput: "Error", messageInput: "Username / Password ?")
            
        }
        
        
        
    }
    
    func makeAlert(titleInput : String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let addbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(addbutton)
        self.present(alert, animated: true, completion: nil)
    }
    


}

