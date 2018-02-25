//
//  ShowCandidatesTableViewController.swift
//  TijerinaIsaac-hw5
//
//  Created by Isaac on 2/24/18.
//  Copyright © 2018 TijerinaIsaac. All rights reserved.
//

import UIKit
import CoreData

class ShowCandidatesTableViewController: UITableViewController {
    //Core data object
    var people = [NSManagedObject]()
    
    //First thing to run when opened
    override func viewDidLoad() {
        super.viewDidLoad()
        //Opens connection to core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        //Gets the info stored in core data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"People")
        var fetchedResults:[NSManagedObject]? = nil
        do{
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        if let results = fetchedResults {
            people = results
        } else{
            print("Could not fetch")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Sets the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Creates new cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //Gets information for cell from people object
        let person = people[indexPath.row]
        let firstName:String = (person.value(forKey: "firstName") as? String)!
        let lastName:String = (person.value(forKey: "lastName") as? String)!
        //Sets the cell text fields
        cell.textLabel!.text = "\(firstName) \(lastName)"
        cell.detailTextLabel!.text = person.value(forKey: "politicalParty") as? String
        return cell
    }
    

    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Gets index of selected cell
        let indexPath = tableView.indexPathForSelectedRow
        //Checks segue identifier
        if segue.identifier == "SendDataSegue" {
            //Finds the destination of the view controller
            if let destination = segue.destination as? CandidateDetailViewController {
                //Sets the information in the destination based on the info in the person object
                let person = people[indexPath!.row]
                destination.firstName = (person.value(forKey: "firstName") as? String)!
                destination.lastName = (person.value(forKey: "lastName") as? String)!
                destination.state = (person.value(forKey: "state") as? String)!
                destination.party = (person.value(forKey: "politicalParty") as? String)!
            }
        }
    }
}
