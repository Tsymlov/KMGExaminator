//
//  DetailViewController.swift
//  KMGExaminator
//
//  Created by Alexey Tsymlov on 2/20/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var secondName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var scores: UITableView!

    var student: Student? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let unwrapedStudent = self.student {
            if let textField = self.firstName {
                firstName.enabled = true
                textField.text = unwrapedStudent.firstName
            }
            if let textField = self.secondName{
                secondName.enabled = true
                textField.text = unwrapedStudent.secondName
            }
            if let textField = self.lastName{
                textField.text = unwrapedStudent.lastName
                lastName.enabled = true
            }
            if let tableView = self.scores{
                tableView.hidden = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scores.dataSource = self
        self.scores.delegate = self
        self.configureView()
    }
    
    @IBAction func updateName() {
        if let unwrapedStudent = self.student {
            unwrapedStudent.firstName = firstName.text
            unwrapedStudent.secondName = secondName.text
            unwrapedStudent.lastName = lastName.text
            updateNamesInMasterView()
        }
    }

    func updateNamesInMasterView(){
        if let splitController = self.splitViewController{
            if splitController.viewControllers.count > 0 {
                let firstController: AnyObject = splitController.viewControllers[0]
                if firstController is UINavigationController {
                    let masterNavigationController = firstController as UINavigationController
                    if masterNavigationController.viewControllers.count > 0 {
                        let masterViewController: AnyObject = masterNavigationController.viewControllers[0]
                        if masterViewController is UITableViewController{
                            if let masTableView = masterViewController.tableView {
                                masTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func scoreTapped(sender: UISegmentedControl) {
        if let unwrapedStudent = student{
            let score = Student.getScoreTypes()[sender.selectedSegmentIndex]
            let marker = Student.getMarkers()[sender.tag]
            unwrapedStudent.scores[marker] = score
        }
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Student.getMarkers().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? ScoreCell {
                let marker = Student.getMarkers()[indexPath.row]
                cell.marker.text = marker

                if let unwrapedStudent = student {
                    let scoreTypes = Student.getScoreTypes()
                    cell.score.selectedSegmentIndex = find(scoreTypes, unwrapedStudent.scores[marker]!)!
                }
                cell.score.tag = indexPath.row

                return cell
            }else{
                return UITableViewCell()
            }
    }
}

