//
//  Equipment.swift
//  WorkoutRecord
//
//  Created by 陳奕帆 on 2025/3/6.
//
import SwiftData

@Model
class Equipment {
    var name: String
    var details: String
    var records: [WorkoutRecord] = []

    init(name: String, details: String) {
        self.name = name
        self.details = details
    }
}


