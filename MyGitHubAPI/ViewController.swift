//
//  ViewController.swift
//  MyGitHubAPI
//
//  Created by macuser on 10/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    var array = ["a", "b", "c", "d", "e", "f"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpTableView()
    }
    
    private func setUpTableView() {
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel!.text = "\(array[indexPath.row])"
        return cell!
    }
}
