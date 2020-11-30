//
//  LogInController.swift
//  Naijahacks2020IOS
//
//  Created by Ibrahim Momoh on 11/29/20.
//

import UIKit
import Parse

class LogInController: UIViewController {

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    @IBAction func signIn(_ sender: Any) {
        guard let username = usernameField.text else {
            return
        }
        guard let password = passwordField.text else {
            return
        }
        
        
        let sv = UIViewController.displaySpinner(onView: self.view)
             PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                 UIViewController.removeSpinner(spinner: sv)
                 if user != nil {
                     self.loadHomeScreen()
                 }else{
                     if let descrip = error?.localizedDescription{
                         self.displayErrorMessage(message: (descrip))
                     }
                 }
             }
    }
    
    
    
    func loadHomeScreen(){
        
        performSegue(withIdentifier: "toFeedFromSignin", sender: nil)
        
        
        
        
    }
    
    func displayErrorMessage(message: String){
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            alertView.addAction(OKAction)
            if let presenter = alertView.popoverPresentationController {
                presenter.sourceView = self.view
                presenter.sourceRect = self.view.bounds
            }
            self.present(alertView, animated: true, completion:nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
