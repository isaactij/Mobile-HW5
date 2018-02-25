//
//  AddCandidateViewController.swift
//  TijerinaIsaac-hw5
//
//  Created by Isaac on 2/24/18.
//  Copyright © 2018 TijerinaIsaac. All rights reserved.
//

import UIKit
import CoreData

class AddCandidateViewController: UIViewController, UITextFieldDelegate {
    //Core data object
    var people = [NSManagedObject]()
    
    //Connections to the storyboard
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var partyController: UISegmentedControl!
    @IBOutlet weak var messageLabel: UILabel!

    //First function that runs
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets the message text to blank so the user does not see anything initially
        messageLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Runs when save button is pressed
    @IBAction func buttonHandler(_ sender: Any) {
        //Calls function to see if the text fields are empty
        if fieldsAreEmpty() {
            //If one or more are empty then dispalys a message
            messageLabel.text = "You must enter a value for all fields"
        }else{
            //Connects to Core Data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            //Creates new entity that will hold the information to be added to Core Data
            let entity = NSEntityDescription.entity(forEntityName: "People", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto:managedContext)
            //Gets value of the party controller and determins the corresponding party
            let segmentIndex:Int = partyController.selectedSegmentIndex
            var party:String = ""
            if segmentIndex == 0 {
                party = "Democrat"
            }else{
                party = "Republican"
            }
            //Sets the values of the core data object
            person.setValue(firstNameTextField.text, forKey: "firstName")
            person.setValue(lastNameTextField.text, forKey: "lastName")
            person.setValue(stateTextField.text, forKey: "state")
            person.setValue(party, forKey: "politicalParty")
            //Saves to core data
            do{
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
            people.append(person)
            //Displays message upon success
            messageLabel.text = "Candidate Saved!"
        }
        //Closes keyboard
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        stateTextField.resignFirstResponder()
    }
    
    //Checks to see if any of the fields are empty and returns true if one or more are
    func fieldsAreEmpty() -> Bool{
        //Var to be returned
        var empty:Bool = false
        //Goes through each text field to see if empty
        if firstNameTextField.text == ""{
            empty = true
        }else if lastNameTextField.text == "" {
            empty = true
        }else if stateTextField.text == "" {
            empty = true
        }
        return empty
    }
    
    //Closes the keyboard if Done is pressed
    func textFieldShouldReturn(_ textField:UITextField) -> Bool{
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        stateTextField.resignFirstResponder()
        return true
    }
    
    //Closes the keyboard if anywhere other than a text field is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
