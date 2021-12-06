//
//  ViewController.swift
//  Homework32DateApp
//
//  Created by 黃柏嘉 on 2021/12/6.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    

    @IBOutlet weak var backScrollView: UIScrollView!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var chineseCalendarBirthday: UILabel!
    @IBOutlet weak var leapYearSegmentedControl: UISegmentedControl!
    @IBOutlet weak var weekSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var constellationPickerView: UIPickerView!
    let constellationArray = ["牡羊座","金牛座","雙子座","巨蟹座","獅子座","處女座","天秤座","天蠍座","射手座","摩羯座","水瓶座","雙魚座"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景移動
       moveBackView()
        //當日農曆
        showChineseCalendarBirthday(birthday: birthdayDatePicker.date)
        //當年閏年與否
        checkLeapYear(birthday: birthdayDatePicker.date)
        //當日星期幾
        showWeek(birthday: birthdayDatePicker.date)
        //當日星座
        if let constellationIndex = showConstellation(birthday: birthdayDatePicker.date){
            constellationPickerView.selectRow(constellationIndex, inComponent: 0, animated: true)
        }
        
    }
    
    @IBAction func selectBirthday(_ sender: UIDatePicker) {
        showChineseCalendarBirthday(birthday: sender.date)
        checkLeapYear(birthday: sender.date)
        showWeek(birthday: sender.date)
        if let constellationIndex = showConstellation(birthday: sender.date){
            constellationPickerView.selectRow(constellationIndex, inComponent: 0, animated: true)
        }
    }
    
    //農曆生日
    func showChineseCalendarBirthday(birthday:Date){
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.calendar = Calendar(identifier: .chinese)
        formatter.locale = Locale(identifier: "zh_TW")
        chineseCalendarBirthday.text = formatter.string(from: birthday)
    }
    //閏年
    func checkLeapYear(birthday:Date){
        let dateComponent = Calendar.current.dateComponents(in: .current, from: birthday)
        if let year = dateComponent.year{
            if year%4 == 0 && year%100 != 0 || year%400 == 0{
                leapYearSegmentedControl.selectedSegmentIndex = 0
            }else{
                leapYearSegmentedControl.selectedSegmentIndex = 1
            }
        }
    }
    //星期幾
    func showWeek(birthday:Date){
        let dateComponent = Calendar.current.dateComponents(in: .current, from: birthday)
        if let week = dateComponent.weekday{
            weekSegmentedControl.selectedSegmentIndex = week-1
        }
    }
    
    //星座
    func showConstellation(birthday:Date)->Int?{
        let dateComponent = Calendar.current.dateComponents(in: .current, from: birthday)
        if let month = dateComponent.month,let day = dateComponent.day{
            if month == 3 && day >= 21 || month == 4 && day <= 19{
                return 0
            }else if month == 4 && day >= 20 || month == 5 && day <= 20{
                return 1
            }else if month == 5 && day >= 21 || month == 6 && day <= 21{
                return 2
            }else if month == 6 && day >= 22 || month == 7 && day <= 22{
                return 3
            }else if month == 7 && day >= 23 || month == 8 && day <= 22{
                return 4
            }else if month == 8 && day >= 23 || month == 9 && day <= 22{
                return 5
            }else if month == 9 && day >= 23 || month == 10 && day <= 23{
                return 6
            }else if month == 10 && day >= 24 || month == 11 && day <= 22{
                return 7
            }else if month == 11 && day >= 23 || month == 12 && day <= 21{
                return 8
            }else if month == 12 && day >= 22 || month == 1 && day <= 19{
                return 9
            }else if month == 1 && day >= 20 || month == 2 && day <= 18{
                return 10
            }else{
                return 11
            }
        }else{
            return nil
        }
    }
    
    
    //PickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return constellationArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return constellationArray[row]
    }
   
    
    //背景移動
    func moveBackView(){
        UIView.animate(withDuration: 60) {
            self.backScrollView.contentOffset.x = self.backScrollView.contentSize.width-self.backScrollView.bounds.width
        } completion: { finished in
            UIView.animate(withDuration: 60) {
                self.backScrollView.contentOffset.x = 0
            }
        }

    }

}

