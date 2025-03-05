//
//  PaymentsCardView.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct PaymentsCardView: View {
	var payment: Payment
	
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(payment.amount.formatted(.currency(code: "AUD")))
					.bold()
				Text(payment.date.formatted(.dateTime.day().month().year().weekday()))
					.font(.caption2)
			}
			Spacer()
			Image(systemName: payment.type.imageName)
		}
	}
}

#Preview {
	PaymentsCardView(payment: .example)
		.padding()
}
