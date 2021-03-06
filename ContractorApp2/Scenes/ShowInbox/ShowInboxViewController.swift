//
//  ShowInboxViewController.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright (c) 2017 Team5. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import HGPlaceholders
import FirebaseAuth
import GoogleSignIn

protocol ShowInboxDisplayLogic: class
{
    func displayInbox(viewModel: ShowInbox.FetchInbox.ViewModel)
}

class ShowInboxViewController: UIViewController, ShowInboxDisplayLogic
{
    var interactor: ShowInboxBusinessLogic?
    var router: (NSObjectProtocol & ShowInboxRoutingLogic & ShowInboxDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ShowInboxInteractor()
        let presenter = ShowInboxPresenter()
        let router = ShowInboxRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    var conversations: [ShowInbox.FetchInbox.ViewModel.DisplayableConversation] = []
    var refresher: UIRefreshControl!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.inboxTableView.register(UINib(nibName: "InboxTableCell", bundle: nil), forCellReuseIdentifier: "InboxCell")
        self.inboxTableView.setAutomaticHeight(estimated: 200)
        self.inboxTableView.tableFooterView = UIView()
        self.inboxTableView.showLoadingPlaceholder()
        
//        refresher = UIRefreshControl()
//        refresher.addTarget(self, action: #selector(), for: .valueChanged)
        
        interactor?.configureDatabase()
        fetchInbox()
    }
    override func viewWillAppear(_ animated: Bool) {
        //        fetchInbox()
        if let user = Auth.auth().currentUser {
            fetchInbox()
        } else {
            self.performSegue(withIdentifier: "Signin", sender: self)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    
    // MARK: Do something
    
    @IBOutlet weak var inboxTableView: TableView!
    
    func fetchInbox() {
        interactor?.fetchInbox()
    }
    func displayInbox(viewModel: ShowInbox.FetchInbox.ViewModel) {
        self.conversations = viewModel.conversations
        if self.conversations.count > 0 {
            self.inboxTableView.reloadData()
        } else {
            self.inboxTableView.showNoResultsPlaceholder()
        }
        
        
        
    }
}
extension ShowInboxViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if conversations.count == 0 {
        //            return 1
        //        }
        return conversations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let data = self.conversations[row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "InboxCell") as! InboxTableCell
        cell.setCell(convo: data)
        
        return cell
    }
}
extension ShowInboxViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowMessages", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

