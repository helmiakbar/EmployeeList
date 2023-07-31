//
//  EmployeeListTableViewCell.swift
//  EmployeeList
//
//  Created by PT Phincon on 30/07/23.
//

import UIKit
import RxSwift

class EmployeeListTableViewCell: UITableViewCell {
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var salaryLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var didTapEdit: ((EmployeeResponse.Employee?) -> Void)?
    var didTapDelete: ((Int?) -> Void)?
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellData(_ data: EmployeeResponse.Employee?) {
        if let validData = data {
            idLbl.text = "\(validData.id ?? 0)"
            nameLbl.text = validData.employeeName
            salaryLbl.text = "\(validData.employeeSalary ?? 0)"
            ageLbl.text = "\(validData.employeeAge ?? 0)"
            editBtn.rx.tap.subscribe({[weak self] _ in
                self?.didTapEdit?(validData)
            }).disposed(by: disposeBag)
            deleteBtn.rx.tap.subscribe({[weak self] _ in
                self?.didTapDelete?(validData.id)
            }).disposed(by: disposeBag)
        }
        
    }
}
