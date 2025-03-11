import SwiftUI
import SwiftData

struct AddEquipmentView: View {
    @Environment(\.dismiss) private var dismiss  // 允許關閉視圖
    @Environment(\.modelContext) private var modelContext  // SwiftData 環境
    
    let defaultEquipmentList = ["槓鈴", "啞鈴", "壺鈴", "深蹲架", "腿推機", "滑輪下拉", "胸推機", "其他"]
    @State private var selectedEquipment: String = "槓鈴"  // 預設選擇第一個器材
    @State private var customEquipment: String = ""  // 讓使用者輸入自訂器材
    
    @State private var weight: String = ""
    @State private var sets: String = ""
    @State private var reps: String = ""
    @State private var selectedUnit: String = "kg"  // 預設單位為公斤
    
    var equipmentImages: [String: String] = [
       "槓鈴": "muscle_barbell",
       "啞鈴": "muscle_dumbbell",
       "壺鈴": "muscle_kettlebell",
       "深蹲架": "muscle_squat",
       "腿推機": "muscle_leg",
       "滑輪下拉": "muscle_back",
       "胸推機": "muscle_chest"
   ]
    
    let weightUnits = ["kg", "lbs"]  // 可選單位

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("選擇器材")) {
                    Picker("器材", selection: $selectedEquipment) {
                        ForEach(defaultEquipmentList, id: \.self) { equipment in
                            Text(equipment)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    if selectedEquipment == "其他" {
                        TextField("請輸入器材名稱", text: $customEquipment)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .listRowBackground(Color(red: 0.80, green: 0.70, blue: 0.60))
               
                Section(header: Text("初始訓練數據（可選）")) {
                    HStack {
                        TextField("重量", text: $weight)
                            .keyboardType(.decimalPad)
                        
                        Picker("單位", selection: $selectedUnit) {
                            ForEach(weightUnits, id: \.self) { unit in
                                Text(unit).tag(unit)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    TextField("次數", text: $reps)
                        .keyboardType(.numberPad)
                    TextField("組數", text: $sets)
                        .keyboardType(.numberPad)
                }
                .listRowBackground(Color(red: 0.80, green: 0.70, blue: 0.60))
                
                // if let imageName = equipmentImages[selectedEquipment] {
                //     Image(imageName)
                //         .resizable()
                //         .scaledToFit()
                //         .frame(height: 200)
                // }
            }
            .navigationTitle("新增器材")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("儲存") {
                        addWorkoutRecord()
                    }
                    .disabled(isSaveDisabled())
                }
            }
            .background(Color(red: 0.80, green: 0.70, blue: 0.60))
            .scrollContentBackground(.hidden)
        }
        .preferredColorScheme(.dark)
    }

    private func addWorkoutRecord() {
        guard let weightValue = Double(weight),
              let repsValue = Int(reps),
              let setsValue = Int(sets) else {
            return
        }

        let finalEquipmentName = selectedEquipment == "其他" ? customEquipment : selectedEquipment
        let weightInKg = selectedUnit == "lbs" ? weightValue * 0.453592 : weightValue
        
        let newWorkoutRecord = WorkoutRecord(
            equipmentName: finalEquipmentName,
            weight: weightInKg,
            reps: repsValue,
            sets: setsValue,
            date: Date()
        )
        
        modelContext.insert(newWorkoutRecord)
        dismiss()
    }
    
    private func isSaveDisabled() -> Bool {
        return (selectedEquipment == "其他" && customEquipment.isEmpty) || weight.isEmpty || reps.isEmpty || sets.isEmpty
    }
}

#Preview {
    AddEquipmentView()
        .modelContainer(for: WorkoutRecord.self, inMemory: true)
}
