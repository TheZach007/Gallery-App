//
//  SignupViewController.swift
//  Gallery-App
//
//  Created by Phincon on 20/01/22.
//

import UIKit
import CoreData

class SignupViewController: UIViewController {

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var adminBtn: UIButton!
    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var alertLabel: UILabel!
    
    var regState = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func adminAction(_ sender: Any) {
        regState = 1
        registerState()
    }
    
    @IBAction func userAction(_ sender: Any) {
        regState = 0
        registerState()
    }
    
    @IBAction func submitAction(_ sender: Any) {
        addData()
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        adminBtn.layer.cornerRadius = adminBtn.frame.height/2
        adminBtn.backgroundColor = UIColor.systemBlue
        adminBtn.setTitleColor(UIColor.white, for: .normal)
        
        userBtn.layer.cornerRadius = userBtn.frame.height/2
        userBtn.layer.borderWidth = 1
        userBtn.layer.backgroundColor = UIColor.white.cgColor
        userBtn.layer.borderColor = UIColor.systemBlue.cgColor
        userBtn.setTitleColor(UIColor.systemBlue, for: .normal)
        
        submitBtn.layer.cornerRadius = submitBtn.frame.height/2
        alertLabel.isHidden = true
    }

    func checkField() {
        if userField.text == "" && passField.text == "" {
            alertLabel.isHidden = false
            alertLabel.text = "Username and Password cannot be emptied!"
        } else {
            
        }
    }
    
    func registerState() {
        switch regState {
        case 0 :
            userBtn.layer.cornerRadius = userBtn.frame.height/2
            userBtn.layer.borderWidth = 1
            userBtn.layer.backgroundColor = UIColor.systemBlue.cgColor
            userBtn.layer.borderColor = UIColor.systemBlue.cgColor
            userBtn.setTitleColor(UIColor.white, for: .normal)
            
            adminBtn.layer.cornerRadius = adminBtn.frame.height/2
            adminBtn.layer.borderWidth = 1
            adminBtn.layer.backgroundColor = UIColor.white.cgColor
            adminBtn.layer.borderColor = UIColor.systemBlue.cgColor
            adminBtn.setTitleColor(UIColor.systemBlue, for: .normal)
            
        case 1 :
            adminBtn.layer.cornerRadius = adminBtn.frame.height/2
            adminBtn.backgroundColor = UIColor.systemBlue
            adminBtn.setTitleColor(UIColor.white, for: .normal)
            
            userBtn.layer.cornerRadius = userBtn.frame.height/2
            userBtn.layer.borderWidth = 1
            userBtn.layer.backgroundColor = UIColor.white.cgColor
            userBtn.layer.borderColor = UIColor.systemBlue.cgColor
            userBtn.setTitleColor(UIColor.systemBlue, for: .normal)
            
        default:
            adminBtn.layer.cornerRadius = adminBtn.frame.height/2
            adminBtn.backgroundColor = UIColor.systemBlue
            adminBtn.setTitleColor(UIColor.white, for: .normal)
            
            userBtn.layer.cornerRadius = userBtn.frame.height/2
            userBtn.layer.borderWidth = 1
            userBtn.layer.backgroundColor = UIColor.white.cgColor
            userBtn.layer.borderColor = UIColor.systemBlue.cgColor
            userBtn.setTitleColor(UIColor.systemBlue, for: .normal)
        }
    }

    @available(iOS 13.0, *)
    func addData() {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Accounts", in : managedContext)!
        let record = NSManagedObject(entity: entity, insertInto: managedContext)
        let randomInt = Int.random(in: 0..<6)
        
        record.setValue(userField.text, forKey: "email")
        record.setValue(passField.text, forKey: "password")
        record.setValue(Int16(randomInt), forKey: "id")
        
        if regState == 1 {
            record.setValue("Admin", forKey: "role")
        } else {
            record.setValue("User", forKey: "role")
        }
        
        do {
            try managedContext.save()
            print("Record Added!")
            let alert = UIAlertController(title: "Sign Up Success!", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Back to Login", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)

                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } catch
        let error as NSError {
            print("Could not save. \(error),\(error.userInfo)")
        }
    }
    
}
