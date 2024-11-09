import SwiftUI

struct InfoPatient: View {
    @State var viewModel: InfoPatientVM
    
    init(patient: Patient){
        self.viewModel = .init(patient: patient)
    }

    
    var body: some View {
        Form {
            Section(header: Text("Patient Details").font(.headline)) {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(viewModel.model.patient.name ?? "No name")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Health Service Number")
                    Spacer()
                    Text(viewModel.model.patient.healthServiceNumber ?? "Not provided")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Phone Number")
                    Spacer()
                    Text(viewModel.model.patient.phoneNumber ?? "Not provided")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Age")
                    Spacer()
                    Text("\(viewModel.calculateAge(from: viewModel.model.patient.birthDateAsDate)) years")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Birth Date")
                    Spacer()
                    DatePicker("Select date", selection: $viewModel.model.patient.birthDateAsDate, displayedComponents: .date)
                        .labelsHidden()
                }
            }
            
            Section(header: Text("Physical Metrics").font(.headline)) {
                
                HStack {
                    Text("Height (cm)")
                    Spacer()
                    TextField("Height", value: $viewModel.model.patient.height, format: .number)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 100)
                }
                
                HStack {
                    Text("Weight (kg)")
                    Spacer()
                    TextField("Weight", value: $viewModel.model.patient.weight, format: .number)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 100)
                }
            }
        }
        .navigationTitle("Patient Info")
        .padding()
        
        VStack {
            Button {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
                viewModel.updatePatient(method: .production)
                
            } label: {
                Text("Update Patient")
                    .frame(maxWidth: .infinity)
            }
            .tint(.blue)
            
            Button {
                viewModel.deletePatient()
            } label: {
                Text("Delete Patient")
                    .frame(maxWidth: .infinity)
            }
            .tint(.red)
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }
}


#Preview {
    InfoPatient(patient: .init())
}
