//
//  CandidateDetailViewController.swift
//  TijerinaIsaac-hw5
//
//  Created by Isaac on 2/24/18.
//  Copyright © 2018 TijerinaIsaac. All rights reserved.
//

import UIKit
import CoreData

class CandidateDetailViewController: UIViewController {
    //Connections to the storyboard
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    //Core data object
    var people = [NSManagedObject]()
    //Variables set by the segue in ShowCandidateTableViewController
    var firstName:String?
    var lastName:String?
    var state:String?
    var party:String?
    
    //First thing to run when opened
    override func viewDidLoad() {
        super.viewDidLoad()
        //Sets the labels to the information of the person
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        stateLabel.text = state
        partyLabel.text = party
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
