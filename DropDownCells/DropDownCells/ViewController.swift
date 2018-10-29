//
//  ViewController.swift
//  DropDownCells
//
//  Created by 黄伯驹 on 2017/7/14.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

struct Job {
    let title: String
    let description: String
    let salary: String
    let color: UIColor
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    var jobs: [Job] = []
    let appleTheme = [
        UIColor(r: 166, g: 63, b: 149),
        UIColor(r: 122, g: 131, b: 156),
        UIColor(r: 78, g: 166, b: 157),
        UIColor(r: 119, g: 191, b: 99),
        UIColor(r: 217, g: 67, b: 67)
    ]
    
    let backgroundColor = UIColor(r: 50, g: 54, b: 64)
    var t_count = 0
    var lastCell = StackViewCell()
    var button_tag = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColor

        jobs.append(Job(title: "Web Developer", description: "Designs and or develops websites", salary: "$78,257", color: appleTheme[0]))
        jobs.append(Job(title: "Back End Developer", description: "Designs structure backends and API's", salary: "$117,230", color: appleTheme[1]))
        jobs.append(Job(title: "iOS Developer", description: "Develops and or designs iOS applications for iPhones and iPads", salary: "$117,774", color: appleTheme[2]))
        jobs.append(Job(title: "Android Developer", description: "Develops and or designs Android applications for Android devices", salary: "$115,332", color: appleTheme[3]))
        jobs.append(Job(title: "Software Engineer", description: "Develops and Designs Software", salary: "$100,143", color: appleTheme[4]))
        
        tableView = UITableView(frame: view.frame)
        tableView.layer.frame.size.height = view.frame.height * 1.5
        tableView.frame.origin.y += 125
        tableView.register(UINib(nibName: "StackViewCell", bundle: nil), forCellReuseIdentifier: "StackViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = backgroundColor
        view.addSubview(tableView)


        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
        toolBar.sizeToFit()
        toolBar.frame.origin.y = view.frame.height - toolBar.frame.size.height
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addJob))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        toolBar.setItems([flexSpace, addItem, flexSpace], animated: true)
        view.addSubview(toolBar)
    }

    func addJob() {
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == button_tag ? 320 : 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StackViewCell", for: indexPath) as! StackViewCell
        let job = jobs[indexPath.row]
        if !cell.cellExists {
            cell.textView.text = job.description
            cell.salary.text = "Salary: \(job.salary)"
            cell.name.text = "Title: \(job.title)"
            cell.open.setTitle(job.title, for: .normal)
            cell.openView.backgroundColor = jobs[indexPath.row].color
            cell.stuffView.backgroundColor = jobs[indexPath.row].color
            cell.open.tag = t_count
            cell.open.addTarget(self, action: #selector(cellOpened), for: .touchUpInside)
            t_count += 1
            cell.cellExists = true
        }
        
        UIView.animate(withDuration: 0) {
            cell.contentView.layoutIfNeeded()
        }

        return cell
    }
    
    func cellOpened(sender: UIButton) {
        self.tableView.beginUpdates()
        
        let previousCellTag = button_tag
        
        if lastCell.cellExists {
            self.lastCell.animate(duration: 0.2, c: {
                self.view.layoutIfNeeded()
            })
            
            if sender.tag == button_tag {
                button_tag = -1
                lastCell = StackViewCell()
            }
        }
        
        if sender.tag != previousCellTag {
            button_tag = sender.tag
            
            lastCell = tableView.cellForRow(at: IndexPath(row: button_tag, section: 0)) as! StackViewCell
            self.lastCell.animate(duration: 0.2, c: {
                self.view.layoutIfNeeded()
            })
            
        }
        self.tableView.endUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
