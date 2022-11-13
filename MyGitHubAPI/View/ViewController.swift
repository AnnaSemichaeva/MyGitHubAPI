//
//  ViewController.swift
//  MyGitHubAPI
//
//  Created by macuser on 10/3/22.
//

import UIKit

// https://docs.github.com/en/rest

class ViewController: UIViewController {
    
    //var array = ["a", "b", "c", "d", "e", "f"]
    var viewModel = ViewModel()
    var contentSizeSubtraction: Double!
    
    @IBOutlet weak var tableView: UITableView!
    
    let titleView = TitleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.4550600524, green: 0.02154863621, blue: 0.1925193302, alpha: 1)
        
        //setUpTableView()
        initialSetup()
    }
    
    //    private func setUpTableView() {
    //        
    //        
    //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    //        
    //        tableView.backgroundColor = .green
    //        
    //        tableView.delegate = self
    //        tableView.dataSource = self
    //    }
    
    func initialSetup(){
        contentSizeSubtraction = view.frame.size.height + Double(100)
        tableView.register(ReposTableViewCell.self, forCellReuseIdentifier: ReposTableViewCell.reuseId)
        tableView.refreshControl = createRefreshControl()
        loadDataInitially(completion: nil)
        
        navigationItem.titleView = titleView
    }
    
    
    func loadDataInitially(completion: (() -> ())?){
        NetworkingHelpers.decodeDataWithResult(from: viewModel.getGithubRepositoriesLink(), type: [Repository].self, printJSON: false) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result{
                case .success(let repositories):
                    self?.viewModel.setRepositories(newRepos: repositories)
                    self?.viewModel.lastRepoLoadedId = repositories.last?.id ?? 0
                    print("Number of repos: \(repositories.count)")
                case .failure(let error):
                    self?.viewModel.setRepositories(newRepos: [])
                    self?.viewModel.lastRepoLoadedId = 0
                    print("*Couldn't get data = failure: \(error.localizedDescription)")
                }
                
                self?.tableView.reloadData()
                self?.viewModel.fetchingData = false
                
                completion?()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == viewModel.repoDetailsSegueIdentifier, let preparedViewModel = viewModel.getRepositoryDataForCelectedCell() else {
            return
        }
        
        let detailViewController = segue.destination as! RepoDetailsViewController
        detailViewController.setData(tableViewCellViewModel: preparedViewModel)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //array.count
        return viewModel.numberOfRows()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        //cell?.textLabel!.text = "\(array[indexPath.row])"
        //return cell!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.repoCellIdentifier) as! ReposTableViewCell
        cell.setData(viewModel: viewModel.getRepoCellViewModel(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getRepoCellViewModel(for: indexPath).repoCellSizes.repoCellHeight
    }
    
    // MARK: open cell details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowWasSelected(rowIndex: indexPath)
        performSegue(withIdentifier: viewModel.repoDetailsSegueIdentifier, sender: nil)
    }
}

// MARK: pagination related code
extension ViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewModel.fetchingData == false else { return }
        
        let position = scrollView.contentOffset.y
        
        if(position > tableView.contentSize.height - contentSizeSubtraction){
            
            print("fetch more data")
            fetchMoreData()
        }
    }
    
    func fetchMoreData(){
        guard viewModel.fetchingData == false else { print("unknown error"); return }
        
        viewModel.fetchingData = true
        
        self.tableView.tableFooterView = UIHelpers.createSpinnerFooter(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
            NetworkingHelpers.decodeDataWithResult(from: self.viewModel.getGithubRepositoriesLink(previousRepoId: self.viewModel.lastRepoLoadedId), type: [Repository].self, printJSON: false){ [weak self] result in
                
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                    
                    switch result{
                    case .success(let repositories):
                        self?.viewModel.addNewRepositories(newRepos: repositories)
                        self?.tableView.reloadData()
                        self?.viewModel.lastRepoLoadedId = repositories.last?.id ?? 0
                    case .failure(let error):
                        print("Unsuccessfully retrieved data. Error:\n\(error)")
                    }
                    
                    self?.viewModel.fetchingData = false
                }
            }
        }
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
            loadDataInitially {
                sender.endRefreshing()
        }
    }
}
