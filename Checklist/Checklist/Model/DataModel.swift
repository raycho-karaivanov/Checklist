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
            } catch {
                print("Error decoding item array!")
            }
        }
    }
    
    // MARK:- Init methods
    
    init() {
        loadChecklists()
    }
    
}
