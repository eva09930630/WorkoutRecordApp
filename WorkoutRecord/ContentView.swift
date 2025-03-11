import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var workoutRecords: [WorkoutRecord]

    @State private var isAddingEquipment = false

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundColorView()
                VStack {
                    WorkoutListView(workoutRecords: workoutRecords, deleteAction: deleteWorkoutRecord) // 確保 WorkoutListView.swift 存在
                }
            }
            .navigationTitle("訓練記錄")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: WorkoutChartView()) {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isAddingEquipment = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingEquipment) {
                AddEquipmentView()
            }
            .onAppear {
                DispatchQueue.main.async {
                    addTestData()
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    private func deleteWorkoutRecord(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(workoutRecords[index])
        }
    }

    private func addTestData() {
        guard workoutRecords.isEmpty else { return }

        let testData = [
            WorkoutRecord(equipmentName: "槓鈴", weight: 50, reps: 10, sets: 3, date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!),
            WorkoutRecord(equipmentName: "壺鈴", weight: 50, reps: 10, sets: 3, date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!),
            WorkoutRecord(equipmentName: "啞鈴", weight: 20, reps: 12, sets: 3, date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!),
            WorkoutRecord(equipmentName: "壺鈴", weight: 15, reps: 15, sets: 4, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
            WorkoutRecord(equipmentName: "深蹲架", weight: 80, reps: 8, sets: 3, date: Date()),
            WorkoutRecord(equipmentName: "壺鈴", weight: 80, reps: 8, sets: 3, date: Date())
        ]
        
        for record in testData {
            modelContext.insert(record)
            print("✅ 插入數據：\(record.equipmentName) - \(record.date)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WorkoutRecord.self, inMemory: true)
}
