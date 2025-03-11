import SwiftUI

struct WorkoutListView: View {
    var workoutRecords: [WorkoutRecord]
    var deleteAction: (IndexSet) -> Void

    var groupedRecords: [Date: [WorkoutRecord]] {
        Dictionary(grouping: workoutRecords.sorted(by: { $0.date > $1.date })) { record in
            Calendar.current.startOfDay(for: record.date)
        }
    }

    var body: some View {
        ZStack{
            BackgroundColorView()
            List {
                ForEach(groupedRecords.keys.sorted(by: >), id: \.self) { date in
                    Section(header: Text(dateFormatter.string(from: date))) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(groupedRecords[date] ?? [], id: \.id) { record in
                                    WorkoutCardView(record: record)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
                .onDelete(perform: deleteAction)
            }
            .scrollContentBackground(.hidden) // 確保 `List` 不覆蓋背景
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

#Preview {
    WorkoutListView(
        workoutRecords: [
            WorkoutRecord(equipmentName: "槓鈴", weight: 50, reps: 10, sets: 3, date: Date()),
            WorkoutRecord(equipmentName: "壺鈴", weight: 50, reps: 10, sets: 3, date: Date()),
            WorkoutRecord(equipmentName: "壺鈴", weight: 25, reps: 12, sets: 3, date: Date().addingTimeInterval(-86400))
        ],
        deleteAction: { _ in }
    )
}
