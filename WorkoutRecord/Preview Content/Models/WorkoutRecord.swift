import SwiftData
import Foundation

@Model
class WorkoutRecord {
    var equipmentName: String  // 記錄所使用的器材
    var weight: Double
    var reps: Int
    var sets: Int
    var date: Date
    
    init(equipmentName: String, weight: Double, reps: Int, sets: Int, date: Date) {
        self.equipmentName = equipmentName
        self.weight = weight
        self.reps = reps
        self.sets = sets
        self.date = date
    }
}
