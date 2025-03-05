//
//  PaymentPreDetailsViewModel.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import Foundation

@MainActor
class PaymentPreDetailsViewModel: NSObject, ObservableObject {
	@Published var loadingState: LoadingState<Payment> = .loading()

	private var isLoaded = false
	var paymentId: String
	var connectionManager: ConnectionManager
	
	init(paymentId: String, connectionManager: ConnectionManager = ConnectionManagerMock.shared) {
		self.paymentId = paymentId
		self.connectionManager = connectionManager
	}
	
	func load(forceLoad: Bool = false ) async {
		if isLoaded && !forceLoad { return }
		isLoaded = true
		loadingState = .loading(loadingState.currentValue)
		do {
			let data = try await connectionManager.getPaymentDetails(paymentId: paymentId)
			loadingState = .loaded(data)
		} catch {
			loadingState = .error(error)
		}
	}
}
