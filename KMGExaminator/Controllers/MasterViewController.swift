//
//  MasterViewController.swift
//  KMGExaminator
//
//  Created by Alexey Tsymlov on 2/20/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit
import Parse

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var students = NSMutableArray()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.clearsSelectionOnViewWillAppear = false
        self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStudents()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        let controllers = self.splitViewController!.viewControllers
        self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
    }
    
    
    func loadStudents(){
        let query = PFQuery(className: "Student")
        query.orderByAscending("lastName")
        let receivedStudents = query.findObjects()
        println("Successfully retrieved \(students.count) students.")
        for pfStudent in receivedStudents {
            let studentLastName = pfStudent["lastName"] as String
            let studentFirstName = pfStudent["firstName"] as String
            let studentSecondName = pfStudent["secondName"] as String
            let studentScore = pfStudent["scores"] as Dictionary<String,String>
            
            
            let student = Student(studentFirstName, studentSecondName, studentLastName);
            student.scores = pfStudent["scores"] as Dictionary<String,String>
            student.pfObject = pfStudent as PFObject
            println("\(student.fullName)")
            students.addObject(student)
        }
    }

    func insertNewObject(sender: AnyObject) {
        let newStudent = Student("студент", "", "Новый")
        newStudent.saveEventualy()
        students.insertObject(newStudent, atIndex: 0)
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        self.tableView.reloadData()
        self.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Top)
        self.performSegueWithIdentifier("showDetail", sender: self)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = students[indexPath.row] as Student
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.student = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = students[indexPath.row] as Student
        cell.textLabel!.text = object.fullName
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let student = students[indexPath.row] as Student
            student.delete()
            students.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.reloadData()
        tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
    }

}

