//
//  ViewController.swift
//  FirebaseDemos
//
//  Created by hackeru on 9 Kislev 5778.
//  Copyright © 5778 hackeru. All rights reserved.
//

import UIKit
import FirebaseAuth

class AnonymousLoginViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!{
        didSet{
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    func showError(){
        self.name.layer.borderColor = UIColor.red.cgColor
        self.name.layer.borderWidth = 2
        self.name.layer.masksToBounds = true
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        guard let userName = name.text else {showError(); return}
        if userName.isEmpty {showError(); return}
        
        toggleProgress(show: true)
        
        Auth.auth().signInAnonymously { (user, err) in
            self.toggleProgress(show: false)
            if let err = err {
                print(err)
                self.showError();return
            }
            
            guard let user = user else{
                return
            }
            
            let request = user.createProfileChangeRequest()
            request.displayName = userName
            request.commitChanges(completion: { (err) in
                if err == nil{
                    self.performSegue(withIdentifier: "loggedIn", sender: userName)
                }
            })
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController{
            if let dest = nav.viewControllers[0] as? MainViewController {
                dest.userName = sender as? String
            }
        }
    }
        
    
    func toggleProgress(show:Bool){
        show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

