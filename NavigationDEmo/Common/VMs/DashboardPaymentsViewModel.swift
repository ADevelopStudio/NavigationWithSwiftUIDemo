//
//  DashboardPaymentsViewModel_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import Foundation
@MainActor
class DashboardPaymentsViewModel: NSObject, ObservableObject {
	@Published var loadingState: LoadingState<Payment> = .loading()

	private var isLoaded = false
	private var repo: AppRepository

	init(repo: AppRepository = MainRepo.shared) {
		self.repo = repo
	}
	
	func load(forceLoad: Bool = false ) async {
		if isLoaded && !forceLoad { return }
		isLoaded = true
		loadingState = .loading(loadingState.currentValue)
		
		do {
			let data: Payment = try await repo.load()
			loadingState = .loaded(data)
		} catch {
			Log.error(error.localizedDescription)
			if let currentValue = loadingState.currentValue {
				loadingState = .loaded(currentValue)
			} else {
				loadingState = .error(error)
			}
		}
	}
}
