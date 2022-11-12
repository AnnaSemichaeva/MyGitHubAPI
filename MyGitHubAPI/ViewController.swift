//
//  ViewController.swift
//  MyGitHubAPI
//
//  Created by macuser on 10/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    var array = ["a", "b", "c", "d", "e", "f"]
    var contentSizeSubtraction: Double!
    
    @IBOutlet weak var tableView: UITableView!
    
    let titleView = TitleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.4550600524, green: 0.02154863621, blue: 0.1925193302, alpha: 1)
        
        setUpTableView()
    }
    
    private func setUpTableView() {
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.backgroundColor = .green
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func initialSetup(){
        contentSizeSubtraction = view.frame.size.height + Double(100)
        tableView.register(ReposTableViewCell.self, forCellReuseIdentifier: ReposTableViewCell.reuseId)
        tableView.refreshControl = createRefreshControl()
        //loadDataInitially(completion: nil)
        
        navigationItem.titleView = titleView
    }
}
    
//    func loadDataInitially(completion: (() -> ())?){
//        NetworkingHelpers.decodeDataWithResult(from: viewModel.getGithubRepositoriesLink(), type: [Repository].self, printJSON: false) { [weak self] result in
//
//            DispatchQueue.main.async {
//                switch result{
//                case .success(let repositories):
//                    self?.viewModel.setRepositories(newRepos: repositories)
//                    self?.viewModel.lastRepoLoadedId = repositories.last?.id ?? 0
//                    print("Number of repos: \(repositories.count)")
//                case .failure(let error):
//                    self?.viewModel.setRepositories(newRepos: [])
//                    self?.viewModel.lastRepoLoadedId = 0
//                    print("*Couldn't get data = failure: \(error.localizedDescription)")
//                }
//
//                self?.tableView.reloadData()
//                self?.viewModel.fetchingData = false
//
//                completion?()
//            }
//        }
//    }
//
//}

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


    // MARK: pull to refresh
extension ViewController {
        
        private func createRefreshControl() -> UIRefreshControl{
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(onCalledToRefresh(sender:)), for: .valueChanged)
            
            return refreshControl
        }
        
        @objc private func onCalledToRefresh(sender: UIRefreshControl){
            print("onCalledToRefresh")
//            loadDataInitially {
//                sender.endRefreshing()
//            }
        }
    }
