//
//  SubscriptionListCard.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 16/07/21.
//

import SwiftUI

struct SubscriptionListCard: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        List{
            ForEach(viewModel.subscriptions) { service in
                SubscriptionListCardCell(viewModel: viewModel, subscription: service)
                    .contentShape(Rectangle()) // fixes onTapGesture not working with empty spaces.
                    .onTapGesture {
                        print("payment start date for \(service.serviceName) is \(service.subStartDate)")
                        print("payment date for \(service.serviceName) is \(service.paymentDate)")
                        
                        viewModel.selectedSubscription = service
                        
                        withAnimation {
                            viewModel.isShowingDetailView = true
                        }
                    }
            }
            .onDelete(perform: { indexSet in
                viewModel.deleteSubscription(at: indexSet)
            })
            .listRowBackground(Color(colorScheme == .dark ? .secondarySystemBackground : .systemBackground))
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
        //.padding()
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(Color(colorScheme == .dark ? .secondarySystemBackground : .systemBackground)))
        .padding(.horizontal, 10)
    }
}

struct SubscriptionListCard_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionListCard(viewModel: SubTrackViewModel())
    }
}

struct SubscriptionListCardCell: View {
    
    @ObservedObject var viewModel: SubTrackViewModel
    var subscription: Subscription
    
    var body: some View {
        HStack{
            Image(systemName: subscription.serviceSymbol.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(subscription.serviceName)
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text(subscription.paymentFrequency.rawValue)
                    .font(.body)
                    .italic()
            }.padding(.leading, 10)
            
            Spacer()
            
            Text("\(Currency.allCases[viewModel.currency].rawValue)\(subscription.price, specifier: "%.\(viewModel.decimalAmount)f")")
                .font(.title3)
        }
    }
}
