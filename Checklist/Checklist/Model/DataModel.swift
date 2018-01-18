//
//  DataModel.swift
//  Checklist
//
//  Created by Raycho Karaivanov on 17.01.18.
//  Copyright © 2018 Raycho Karaivanov. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    
    // MARK:- UserDefaults
    
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
        }
    }
    
    // MARK:- Set UserDefault default value
    
    func registerDefaults() {
        
        let dictionary: [String: Any] = [ "ChecklistIndex": -1, "FirstTime": true ]
        
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    // MARK:- Handle First Time Use
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
    
    // MARK:- Sort the Checklists
    
    func sortChecklists() {
        lists.sort(by: { checklist1, checklist2 in return checklist1.name.localizedStandardCompare(checklist2.name) == .orderedAscending })
    }
    
    // MARK:- Load and Save Functions
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array!")
        }
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Checklist].self, from: data)
                sortChecklists()
            } catch {
                print("Error decoding item array!")
            }
        }
    }
    
    // MARK:- Init methods
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
}
