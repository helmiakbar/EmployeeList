//
//  AddEmployeeViewController.swift
//  EmployeeList
//
//  Created by PT Phincon on 29/07/23.
//

import UIKit
import RxSwift
import SkeletonView

class AddEmployeeViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var salaryField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var showAllEmployeeBtn: UIButton!
    
    var isEdit = false
    var employee: EmployeeResponse.Employee?
    var disposeBag = DisposeBag()
    var viewModel = Dependency().resolve(AddEmployeeViewModel.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
    }
    
    private func configureView() {
        if isEdit {
            if let validEmployee = employee {
                nameField.text = validEmployee.employeeName
                ageField.text = "\(validEmployee.employeeAge ?? 0)"
                salaryField.text = "\(validEmployee.employeeSalary ?? 0)"
            }
            submitBtn.titleLabel?.text = "Save"
            showAllEmployeeBtn.isHidden = true
        }
    }
    
    private func showLoading() {
        view.subviews.forEach ({ view in
            view.showAnimatedSkeleton()
        })
    }
    
    private func hideLoading() {
        view.subviews.forEach ({ view in
            view.stopSkeletonAnimation()
            view.hideSkeleton()
        })
    }
    
    private func bindViewModel() {
        viewModel.state.asObservable()
            .subscribe(onNext: { [weak self] state in
                guard let weakSelf = self else { return }
                switch state {
                case .loading, .notLoad:
                    print("loading")
                case .failed:
                    let status = weakSelf.isEdit ? "Add" : "Update"
                    weakSelf.showError(title: "Failed", message: "Failed \(status) Employee")
                case .finished:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        weakSelf.nameField.text = ""
                        weakSelf.ageField.text = ""
                        weakSelf.salaryField.text = ""
                        let status = weakSelf.isEdit ? "Add" : "Update"
                        weakSelf.showError(title: "Success", message: "Success \(status) Employee")
                        if weakSelf.isEdit {
                            weakSelf.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    //MARK: - ButtonAction
    @IBAction func submitBtn(_ sender: Any) {
        if (nameField.text ?? "" != "") && (salaryField.text ?? "" != "") && (ageField.text ?? "" != "") {
            if !isEdit {
                let request = AddEmployeeRequestModel(name: nameField.text, age: Int(ageField.text ?? "0"), salary: Int(salaryField.text ?? "0"))
                viewModel.AddEmployee(request)
            } else {
                if let validEmployee = employee {
                    let request = UpdateEmployeeRequestModel(id: validEmployee.id, name: nameField.text, age: Int(ageField.text ?? "0"), salary: Int(salaryField.text ?? "0"))
                    viewModel.updateEmployee(request)
                }
                
            }
        }
    }
    
    @IBAction func showAllEmployee(_ sender: Any) {
        let vc = EmployeeListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
