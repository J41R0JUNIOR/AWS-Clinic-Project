import SwiftUI

struct PatientList: View {
    @Bindable var viewModel = PatientListVM()
    
    var body: some View {
        VStack {
            Text("Patients list")
                .font(.headline)
            
            Spacer()
            
            if viewModel.model.isLoading {
                ProgressView("Loading...")
                
                Spacer()
                
            } else if let errorMessage = viewModel.model.errorMessage {
                Text("Erro: \(errorMessage)")
                    .foregroundColor(.red)
                
            } else {
                List(viewModel.model.patientsLoaded) { patient in
                    Button{
                        viewModel.model.router.push(.patientDetails(patient))
                    } label: {
                        VStack(alignment: .leading){
                            Text(patient.name ?? "Nome indisponível")
                            Text(viewModel.formatPhoneNumber(patient.phoneNumber ?? ""))
                                .font(.footnote)
                        }
                    }
                }
                .refreshable(action: {
                    await viewModel.loadPatients(method: .production)
                })
                .listStyle(PlainListStyle())
            }
            
            Button {
                viewModel.model.router.push(.createPatient)
            } label: {
                Text("Create Patient")
                    .frame(maxWidth: .infinity)
            }
            .tint(.blue)
            .buttonStyle(.borderedProminent)
        }
//        .toolbar(content: {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button{
//                    
//                }label: {
//                    Image(systemName: "plus")
//                }
//            }
//        })
        
        .task {
            await viewModel.loadPatients(method: .production)
        }
        
        .padding()
    }
}

#Preview {
    NavigationStack{
        PatientList().environmentObject(Router.shared)
    }
}
