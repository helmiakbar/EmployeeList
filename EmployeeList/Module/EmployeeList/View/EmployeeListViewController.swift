//
//  EmployeeListViewController.swift
//  EmployeeList
//
//  Created by PT Phincon on 30/07/23.
//

import UIKit
import RxSwift
import SkeletonView

class EmployeeListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    var viewModel = Dependency().resolve(EmployeeListViewModel.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigation(title: "Employee List")
        configureTableView()
        bindViewModel()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: String(describing: EmployeeListTableViewCell.self), bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: String(describing: EmployeeListTableViewCell.self))
    }
    
    private func bindViewModel() {
        viewModel.state.asObservable()
            .subscribe(onNext: { [weak self] state in
                guard let weakSelf = self else { return }
                switch state {
                case .failed, .loading, .notLoad:
                    weakSelf.tableView.showAnimatedSkeleton()
                case .finished:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        weakSelf.tableView.hideSkeleton()
                        weakSelf.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
        
        viewModel.deleteEmployeeState
            .asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] state in
                guard let weakSelf = self else { return }
                switch state {
                case .loading, .notLoad:
                    weakSelf.tableView.showAnimatedSkeleton()
                case .failed:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        weakSelf.tableView.hideSkeleton()
                        weakSelf.tableView.reloadData()
                        weakSelf.showError(title: "", message: weakSelf.viewModel.errorModel?.detail ?? "")
                    }
                case .finished:
                    weakSelf.viewModel.loadEmployee()
                }
            }).disposed(by: disposeBag)
        viewModel.loadEmployee()
    }
    
    private func openEditForm(_ data: EmployeeResponse.Employee?) {
        let vc = AddEmployeeViewController()
        vc.isEdit = true
        vc.employee = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getEmployeeCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmployeeListTableViewCell.self)) as? EmployeeListTableViewCell {
            let employee = viewModel.getEmployee(indexPath.row)
            cell.configureCellData(employee)
            cell.didTapEdit = { [weak self](data) in
                guard let weakSelf = self else { return }
                weakSelf.openEditForm(data)
            }
            cell.didTapDelete = { [weak self](id) in
                guard let weakSelf = self else { return }
                weakSelf.viewModel.deleteEmployee(employee)
            }
            if (indexPath.row % 2 == 0) {
                cell.backgroundColor = UIColor(hexString: "#C5DFF8")
            } else {
                cell.backgroundColor = UIColor(hexString: "#A0BFE0")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension EmployeeListViewController: SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
        
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
        
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return String(describing: EmployeeListTableViewCell.self)
    }
}
