//
//  FeedViewController.swift
//  Naijahacks2020IOS
//
//  Created by Ibrahim Momoh on 11/30/20.
//

import UIKit
import Parse

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logginOut(_ sender: Any) {
        
        let sv = UIViewController.displaySpinner(onView: self.view)
             PFUser.logOutInBackground { (error: Error?) in
                 UIViewController.removeSpinner(spinner: sv)
                 if (error == nil){
                     self.loadLoginScreen()
                 }else{
                     if let descrip = error?.localizedDescription{
                         self.displayErrorMessage(message: descrip)
                     }else{
                         self.displayErrorMessage(message: "error logging out")
                     }

                 }
             }
    }
    
    func loadLoginScreen(){
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
         viewController.modalPresentationStyle = .fullScreen
         self.present(viewController, animated: true, completion: nil)
     }
    
    func displayErrorMessage(message:String) {
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
