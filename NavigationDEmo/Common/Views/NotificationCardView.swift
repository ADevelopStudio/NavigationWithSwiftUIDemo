//
//  NotificationCardView.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct NotificationCardView: View {
	var notification: AppNotification
	
	init(_ notification: AppNotification) {
		self.notification = notification
	}
	
    var body: some View {
		HStack {
			Text(notification.text)
				.multilineTextAlignment(.leading)
			Spacer()
			Image(systemName: "chevron.right")
		}
		.padding(.vertical, 4)
		.tint(.primary)
	}
}

#Preview {
	if let first = AppNotification.examples.first {
		NotificationCardView(first)
	}
}
