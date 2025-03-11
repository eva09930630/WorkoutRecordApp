import Foundation

enum TimeGrouping: String, CaseIterable, Identifiable {
    case day = "每日"
    case month = "每月"

    var id: Self { self }
}
