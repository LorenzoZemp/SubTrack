//
//  AddSubscriptionView.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 6/07/21.
//

import SwiftUI

struct AddSubscriptionView: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Subscription Details")) {
                        TextField("Name", text: $viewModel.subName)
                        TextField("Price", text: $viewModel.subPrice)
                        DatePicker("Start Date", selection: $viewModel.subDate, displayedComponents: .date)
                        Picker("Payment Frequency", selection: $viewModel.paymentFreqPicked) {
                            ForEach(PaymentFrequency.allCases.indices) { index in
                                Text(PaymentFrequency.allCases[index].rawValue)
                            }
                        }
                    }
                    
                    Section(header: Text("Subscription Icon")) {
                        NavigationLink("Pick Icon", destination: IconPickerView(viewModel: viewModel))
                    }
                    
                    Section {
                        Button {
                            viewModel.addSubscription()
                            viewModel.retrieveSubscriptions()
                        } label: {
                            Text("Add New Subscription")
                        }
                    }
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
                .navigationTitle("Add Subscription")
            }
        }
        .onDisappear {
            UITableView.appearance().backgroundColor = .clear
        }
        .overlay(
            Button {
                viewModel.isShowingAddSubscription = false
            } label: {
            XDismissButton()
            }.padding(), alignment: .topTrailing)
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

struct AddSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubscriptionView(viewModel: SubTrackViewModel())
    }
}
