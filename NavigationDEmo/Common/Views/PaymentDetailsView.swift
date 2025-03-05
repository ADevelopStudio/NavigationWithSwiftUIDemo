//
//  PaymentDetailsView.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct PaymentDetailsView: View {
	var payment: Payment
	
	var body: some View {
		VStack(spacing: 20) {
			Text(payment.amount.formatted(.currency(code: "AUD")))
				.font(.largeTitle)
				.bold()
			Text(payment.date.formatted(.dateTime.day().month().year().weekday()))
			Label(String(describing: payment.type).uppercased(), systemImage: payment.type.imageName)
			if let url = URL(string: payment.invoiceUrl) {
				Link("Print invoice", destination: url)
			}
			Spacer()
		}
		.padding()
	}
}

#Preview {
	PaymentDetailsView(payment: .example)
}
