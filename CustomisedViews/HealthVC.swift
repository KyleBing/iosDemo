//
//  HealthVC.swift
//  iosDemo
//
//  Created by Kyle on 2017/6/25.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit
import HealthKit

class HealthVC: UIViewController, UITextFieldDelegate {
    
    var canAccessToHK: Bool = false {
        didSet{
            refreshSteps()
        }
    }
    var kit: HKHealthStore!
    
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var stepsTextField: UITextField!
    
    
    //  MARK: - Life Cirle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kit = HKHealthStore()
        stepsTextField.delegate = self  // Text Field Delegete
        
        getAuthorizationFromHK()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshSteps()
    }
    
    
    
    // MARK: - TextField Delegete
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let steps = Double(textField.text ?? "") {
            addStepsToHKStore(steps)
        }
        return true
    }
    
    
    
    // MARK: - HK Operation
    func getAuthorizationFromHK() {
        if HKHealthStore.isHealthDataAvailable(){
            //  Write Authorize
            let shareArr: Set<HKSampleType> = [
                HKSampleType.quantityType(forIdentifier: .stepCount)!
            ]
            //  Read Authorize
            let readArr: Set<HKObjectType> = [
                HKObjectType.characteristicType(forIdentifier: .biologicalSex)!,
                HKObjectType.characteristicType(forIdentifier: .bloodType)!,
                HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!,
                HKObjectType.characteristicType(forIdentifier: .fitzpatrickSkinType)!,
                HKObjectType.characteristicType(forIdentifier: .wheelchairUse)!,
                HKObjectType.quantityType(forIdentifier: .stepCount)!
            ]
            kit.requestAuthorization(toShare: shareArr, read: readArr) { (bool, error) in
                self.canAccessToHK = bool
            }
        }
    }
    
    func addStepsToHKStore(_ count: Double){
        if canAccessToHK {
            let typeNeedsUpload = HKObjectType.quantityType(forIdentifier: .stepCount)  // type
            let instanceNeedsUpload = HKQuantitySample(type: typeNeedsUpload!,  // sample
                quantity: HKQuantity(unit: HKUnit.count(), doubleValue: count),
                start: Date(timeIntervalSinceNow: -60),
                end: Date(),
                metadata: nil)
            
            kit.save(instanceNeedsUpload, withCompletion: { (bool, error) in
                if bool, count > 0 {
                    let alertVC = UIAlertController(title: "添加成功", message: String(format: "成功添加了 %.f 步", count), preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.refreshSteps()
                    })
                    alertVC.addAction(okAction)
                    DispatchQueue.main.async {
                        self.present(alertVC, animated: true, completion: nil)
                    }
                } else {
                    let alertVC = UIAlertController(title: "添加失败", message: "步数不能少于 0", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.refreshSteps()
                    })
                    alertVC.addAction(okAction)
                    DispatchQueue.main.async {
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    
    func refreshSteps(){
        if canAccessToHK {
            //  Statistic Query
            let calendar = Calendar.current
            let todayStart =  calendar.date(from: calendar.dateComponents([.year,.month,.day], from: Date()))
            let dayPredicate = HKQuery.predicateForSamples(withStart: todayStart,
                                                           end: Date(timeInterval: 24*60*60,since: todayStart!),
                                                           options: HKQueryOptions.strictStartDate)
            let queryOneDaySteps = HKStatisticsQuery(quantityType: HKObjectType.quantityType(forIdentifier: .stepCount)!,
                                                     quantitySamplePredicate: dayPredicate,
                                                     options: HKStatisticsOptions.cumulativeSum,
                                                     completionHandler: { (query, statistics, error) in
                                                        if let samples = statistics {
                                                            let steps = samples.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
                                                            DispatchQueue.main.async {      // Dispatch to Main Queue
                                                                self.stepsLabel.text = String(format: "%.f", steps)
                                                            }
                                                        }
                                                        
            })
            kit.execute(queryOneDaySteps)
        }
    }
    
    
    
    // MARK: - After Use
    //  Quantity Query
    /*
    let sampleType = HKSampleType.quantityType(forIdentifier: .stepCount)
    let query = HKSampleQuery(sampleType: sampleType!,
                              predicate: nil,
                              limit: 20,
                              sortDescriptors: nil,
                              resultsHandler: { (query, samples, error) in
                                print("Step Count Times: ",samples?.count ?? "None")
    })
    kit.execute(query)
     */

}
