//
//  MainViewController.swift
//  FirebaseDemos
//
//  Created by hackeru on 9 Kislev 5778.
//  Copyright © 5778 hackeru. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    @IBAction func signOut(_ sender: UIBarButtonItem) {
        try? Auth.auth().signOut()
    }
    var userName:String?{
        didSet{
            self.navigationItem.title = userName
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser // get the user from everywhere in the application.

        
      
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                //goto login...
                print("Goto Login...")
            }
        }
    }

    var handle: NSObjectProtocol?
    deinit {
        if let handle = handle{
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
