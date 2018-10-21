//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Denis Zubkov on 18/10/2018.
//  Copyright © 2018 Denis Zubkov. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfChildrensLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrensStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    var roomTypes: [RoomType] = []
    var currentRoomType: RoomType?
    
    var isCheckInDatePickerShow = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShow
        }
    }
    
    var isCheckOutDatePickerShow = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShow
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRoomTypes()
        setupRegistrationForm()
        updateDateViews()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isCheckInDatePickerShow = false
        isCheckOutDatePickerShow = false
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func loadRoomTypes() {
        roomTypes.append(RoomType(id: 1, name:  "1-местный Стандартный", shortName: "1СТД", price: 100  ))
        roomTypes.append(RoomType(id: 2, name:  "2-местный Стандартный", shortName: "2СТД", price: 120  ))
        roomTypes.append(RoomType(id: 3, name:  "2-местный Люкс", shortName: "2ЛЮКС", price: 200  ))
        roomTypes.append(RoomType(id: 4, name:  "3-местный Люкс", shortName: "3ЛЮКС", price: 250 ))
        roomTypes.append(RoomType(id: 5, name:  "Супер Люкс", shortName: "СУПЕРЛЮКС", price: 500  ))
    }
    
    func setupRegistrationForm() {
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        numberOfAdultsStepper.minimumValue = 0
        numberOfAdultsStepper.maximumValue = 10
        numberOfAdultsStepper.stepValue = 1
        numberOfAdultsStepper.value = 0
        numberOfAdultsLabel.text = "0"
        
        numberOfChildrensStepper.minimumValue = 0
        numberOfChildrensStepper.maximumValue = 10
        numberOfChildrensStepper.stepValue = 1
        numberOfChildrensStepper.value = 0
        numberOfChildrensLabel.text = "0"
        
        wifiSwitch.isOn = false
        roomTypeLabel.text = "Не указан"
        
    }
    
    func updateDateViews() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)

        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        dateFormater.locale = Locale(identifier: "ru_RU")
        checkInDateLabel.text = dateFormater.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormater.string(from: checkOutDatePicker.date)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShow {
                return 216
            } else {
                return 0
            }
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShow {
                return 216
            } else {
                return 0
            }
        default:
            return 44
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if firstNameTextField.isEditing && indexPath.section > 0 {
            firstNameTextField.resignFirstResponder()
        }
        if lastNameTextField.isEditing && indexPath.section > 0 {
            lastNameTextField.resignFirstResponder()
        }
        if emailTextField.isEditing && indexPath.section > 0 {
            emailTextField.resignFirstResponder()
        }
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            if isCheckInDatePickerShow {
                isCheckInDatePickerShow = false
            } else if isCheckOutDatePickerShow {
                isCheckOutDatePickerShow = false
                isCheckInDatePickerShow = true
            } else {
                isCheckInDatePickerShow = true
            }
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            if isCheckOutDatePickerShow {
                isCheckOutDatePickerShow = false
            } else if isCheckInDatePickerShow {
                isCheckInDatePickerShow = false
                isCheckOutDatePickerShow = true
            } else {
                isCheckOutDatePickerShow = true
            }
            
        default:
            isCheckInDatePickerShow = false
            isCheckOutDatePickerShow = false
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func showMessage(title: String, message: String) {
        let alertData = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertData.addAction(cancelAction)
        present(alertData, animated: true, completion: nil)
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        dateFormater.locale = Locale(identifier: "ru_RU")
        let checkInDate = dateFormater.string(from: checkInDatePicker.date)
        let checkOutDate = dateFormater.string(from: checkOutDatePicker.date)
        
        let numberOfAdults = Int(numberOfAdultsLabel.text ?? "0") ?? 0
        let numberOfChildrens = Int(numberOfChildrensLabel.text ?? "0") ?? 0
        let wifiEnabled = wifiSwitch.isOn ? "Доступен" : "Недоступен"
        let roomType = currentRoomType?.name ?? "Не указан"
        
        
        print(#function)
        print("Имя: \(firstName)")
        print("Фамилия: \(lastName)")
        print("Email: \(email)")
        print("Дата заезда: \(checkInDate)")
        print("Дата выезда: \(checkOutDate)")
        print("Количество взрослых: \(numberOfAdults)")
        print("Количество детей: \(numberOfChildrens)")
        print("Wi-fi: \(wifiEnabled)")
        print("Тип номера: \(roomType)")
        
        let message  = "Имя: \(firstName)\nФамилия:\(lastName)\nEmail: \(email)\nДата заезда: \(checkInDate)\nДата выезда: \(checkOutDate)\nКоличество взрослых: \(numberOfAdults)\nКоличество детей: \(numberOfChildrens)\nWi-fi: \(wifiEnabled)\nТип номера: \(roomType)"
        showMessage(title: "Регистрация", message: message)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func numberOfAdultsStepperChanged(_ sender: UIStepper) {
        numberOfAdultsLabel.text = String(format:"%.0f",numberOfAdultsStepper.value)
    }
    
    @IBAction func numberOfChildrensStepperChanged(_ sender: UIStepper) {
        numberOfChildrensLabel.text = String(format:"%.0f",numberOfChildrensStepper.value)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomSegue" {
                let dvc = segue.destination as! AddRoomTableViewController
                dvc.roomTypes = roomTypes
                dvc.currentRoomType = currentRoomType
        }
    }
    
    @IBAction func setRoomType(unwindSegue: UIStoryboardSegue) {
        let dvc = unwindSegue.source as! AddRoomTableViewController
        currentRoomType = dvc.currentRoomType
        if currentRoomType == nil {
            roomTypeLabel.text = "Не указан"
        } else {
            roomTypeLabel.text = currentRoomType?.shortName
        }
    }
    
    
}
