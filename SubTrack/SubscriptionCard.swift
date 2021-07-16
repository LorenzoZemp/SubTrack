//
//  SubscriptionCard.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 16/07/21.
//

import SwiftUI

struct SubscriptionCard: View {
    
    var subscription: Subscription
    
    var body: some View {
        HStack{
            Image(systemName: subscription.serviceSymbol)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(subscription.serviceName)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Text(subscription.paymentFrequency)
                    .font(.body)
                    .italic()
            }.padding(.leading)
            Spacer()
            
            
            Text("$\(subscription.price, specifier: "%.2f")")
                .font(.title3)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(Color(.systemBackground)))
        .padding(.horizontal, 10)
    }
}

struct SubscriptionCard_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionCard(subscription: MockData.service1)
    }
}