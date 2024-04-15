//
//  SelfTestVC.swift
//  dr_online
//
//  Created by Jayanth on 3/20/24.
//

import UIKit
import AudioToolbox
import CoreML

class SelfTestVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    let doctorModel = try? DoctorTest(configuration: MLModelConfiguration())
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedSymptoms: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let symptom = symptomsArray[indexPath.row]
        cell.textLabel?.text = "\(symptom) \(selectedSymptoms.contains(symptom) ? "☑️" : "☐")"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSymptom = symptomsArray[indexPath.row]
        if let index = selectedSymptoms.firstIndex(of: selectedSymptom) {
            selectedSymptoms.remove(at: index)
        } else {
            selectedSymptoms.append(selectedSymptom)
        }
        tableView.reloadData()
    }
    
    
    @IBAction func onPredict(_ sender: Any) {
        
        if selectedSymptoms.isEmpty {
            
            let alert = UIAlertController(title: "No Disease Selected", message: "Please select at least one symptom before predicting.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            recordForDoctorPredict()
        }
        
    }
    
    func recordForDoctorPredict() {
        var symptomValues: [String: Int64] = [:]
        for symptom in symptomsArray {
            symptomValues[symptom] = selectedSymptoms.contains(symptom) ? 1 : 0
        }
        
        let prediction = try! doctorModel?.prediction(
            itching: symptomValues["itching"] ?? 0,
            skin_rash: symptomValues["skin_rash"] ?? 0,
            nodal_skin_eruptions: symptomValues["nodal_skin_eruptions"] ?? 0,
            dischromic__patches: symptomValues["dischromic__patches"] ?? 0,
            continuous_sneezing: symptomValues["continuous_sneezing"] ?? 0,
            stomach_pain: symptomValues["stomach_pain"] ?? 0,
            acidity: symptomValues["acidity"] ?? 0,
            ulcers_on_tongue: symptomValues["ulcers_on_tongue"] ?? 0,
            vomiting: symptomValues["vomiting"] ?? 0,
            cough: symptomValues["cough"] ?? 0,
            chest_pain: symptomValues["chest_pain"] ?? 0,
            high_fever: symptomValues["high_fever"] ?? 0,
            headache: symptomValues["headache"] ?? 0,
            back_pain: symptomValues["back_pain"] ?? 0,
            neck_pain: symptomValues["neck_pain"] ?? 0,
            muscle_pain: symptomValues["muscle_pain"] ?? 0,
            mild_fever: symptomValues["mild_fever"] ?? 0,
            joint_pain: symptomValues["joint_pain"] ?? 0,
            belly_pain: symptomValues["belly_pain"] ?? 0,
            stomach_bleeding: symptomValues["stomach_bleeding"] ?? 0,
            knee_pain: symptomValues["knee_pain"] ?? 0
        )
        
        
        let predictedDisease = prediction!.Disease
        let result = getSpecialtyName(for: (Int(predictedDisease)))
        
        
        
        
        // Show prediction result
        let alert = UIAlertController(title: "Prediction Result", message: "The predicted disease is \(result)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        // Play sound
        AudioServicesPlaySystemSound(1152)
    }
    
    
    
    func studentPredicationAlert(with prediction: String) {
        let titleAlert = "Preliminary Prediction"
        let message = "Admit Status: \(prediction)"
        
        let controller = UIAlertController(title: titleAlert, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        
        present(controller, animated: true, completion: nil)
    }
    
}



func getSpecialtyName(for code: Int) -> String {
    switch code {
    case 1:
        return "Rheumatologist"
    case 2:
        return "Pulmonologist"
    case 3:
        return "Phlebologist"
    case 4:
        return "Pediatrician"
    case 5:
        return "Otolaryngologist"
    case 6:
        return "Osteopathic"
    case 7:
        return "Osteoarthritis"
    case 8:
        return "Neurologist"
    case 9:
        return "Internal Medicine"
    case 10:
        return "Hepatologist"
    case 11:
        return "Gynecologist"
    case 12:
        return "Gastroenterologist"
    case 13:
        return "Endocrinologist"
    case 14:
        return "Dermatologist"
    case 15:
        return "Common Cold"
    case 16:
        return "Cardiologist"
    case 17:
        return "Allergist"
    default:
        return "Unknown Specialty"
    }
}






let symptomsArray = [
    "itching",
    "skin_rash",
    "nodal_skin_eruptions",
    "dischromic_patches",
    "continuous_sneezing",
    "stomach_pain",
    "acidity",
    "ulcers_on_tongue",
    "vomiting",
    "cough",
    "chest_pain",
    "high_fever",
    "headache",
    "back_pain",
    "neck_pain",
    "muscle_pain",
    "mild_fever",
    "joint_pain",
    "belly_pain",
    "stomach_bleeding",
    "knee_pain",
    ]

