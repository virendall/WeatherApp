//
//  ViewController.swift
//  Weather
//
//  Created by Virender Dall on 30/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var bookMarkTableView: UITableView!
    @IBOutlet var _editBarButton: UIBarButtonItem!
    @IBOutlet var addBarButton: UIBarButtonItem!
    @IBOutlet var cancelBarButton: UIBarButtonItem!
    
    lazy var viewModel: BookMarkViewModel = BookMarkViewModel()
    
    lazy var  bag: DisposeBag? = DisposeBag()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        bookMarkTableView.tableFooterView = UIView()
        viewModel.bookMarks.bindAndFire {[weak self] _ in
            self?.bookMarkTableView.reloadData()
        }.disposed(by: bag)
        
        viewModel.editEnabled.bind {[weak self] edit in
            self?.bookMarkTableView.isEditing = edit
            self?.hideShowBarButtons(edit)
        }.disposed(by: bag)
        
        viewModel.bookMarkError.bind(listener: showErrorAlert).disposed(by: bag)
    }
    
    private func setupSearchController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self;
        searchController.searchBar.placeholder = "Search City"
        searchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
    }
    
    @IBAction func editAction() {
        self.viewModel.editToggle()
    }
    
    func hideShowBarButtons(_ edit:Bool) {
        if edit {
            self.navigationItem.leftBarButtonItems = [cancelBarButton]
            self.navigationItem.rightBarButtonItems = nil
        } else {
            self.navigationItem.leftBarButtonItems = [_editBarButton]
            self.navigationItem.rightBarButtonItems = [addBarButton]
        }
    }
    
    deinit {
        bag = nil
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterCities(cityName: searchController.searchBar.text)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filterCities(cityName: nil)
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController, let vc = nav.viewControllers.first as? MapSceneViewController {
            vc.delegate = viewModel;
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalRows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = viewModel.itemAt(index: indexPath.row).cityName
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      defer {
        tableView.reloadData()
      }
      if editingStyle == .delete {
        self.viewModel.deleteItem(index: indexPath.row)
      }
    }
}

extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.loadVC(CityScreenViewController.self) else {
            fatalError("CityScreenViewController storyboard id did not set")
        }
        vc.selectedCity = self.viewModel.itemAt(index: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

