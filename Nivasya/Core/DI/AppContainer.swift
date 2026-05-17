//
//  AppContainer.swift
//  Nivasya
//
//  Created by Nikunj Prajapati
//

import Foundation
import Observation

/// Dependency Injection container for the Nivasya application.
/// All repositories, use cases, and view models are registered here.
/// This is the ONLY place where concrete implementations are wired to protocols.
@Observable
@MainActor
public final class AppContainer {
    public let config: AppConfiguration
    public let apiClient: APIClientProtocol
    public let router: AppRouter
    
    public let propertyRepository: PropertyRepositoryProtocol
    public let favoritesRepository: FavoritesRepositoryProtocol
    public let searchRepository: SearchRepositoryProtocol
    public let propertyDetailRepository: PropertyDetailRepositoryProtocol
    public let chatRepository: ChatRepositoryProtocol
    public let profileRepository: ProfileRepositoryProtocol
    public let notificationsRepository: NotificationsRepositoryProtocol
    
    // MARK: - Use Cases
    
    public let fetchPropertiesUseCase: FetchPropertiesUseCase
    public let searchPropertiesUseCase: SearchPropertiesUseCase
    public let fetchFavoritesUseCase: FetchFavoritesUseCase
    public let toggleFavoriteUseCase: ToggleFavoriteUseCase
    public let fetchPropertyDetailUseCase: FetchPropertyDetailUseCase
    public let sendMessageUseCase: SendMessageUseCase
    public let fetchProfileUseCase: FetchProfileUseCase
    public let updateProfileUseCase: UpdateProfileUseCase
    public let fetchNotificationsUseCase: FetchNotificationsUseCase
    public let markNotificationsReadUseCase: MarkNotificationsReadUseCase
    
    // MARK: - View Models
    
    public func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(fetchPropertiesUseCase: fetchPropertiesUseCase)
    }
    
    public func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(searchPropertiesUseCase: searchPropertiesUseCase)
    }
    
    public func makeFavoritesViewModel() -> FavoritesViewModel {
        FavoritesViewModel(
            fetchFavoritesUseCase: fetchFavoritesUseCase,
            toggleFavoriteUseCase: toggleFavoriteUseCase
        )
    }
    
    public func makePropertyDetailViewModel(property: Property) -> PropertyDetailViewModel {
        PropertyDetailViewModel(
            property: property,
            toggleFavoriteUseCase: toggleFavoriteUseCase
        )
    }
    
    public func makeChatViewModel() -> ChatViewModel {
        ChatViewModel(sendMessageUseCase: sendMessageUseCase, chatRepository: chatRepository)
    }
    
    public func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(fetchProfileUseCase: fetchProfileUseCase, updateProfileUseCase: updateProfileUseCase)
    }
    
    public func makeNotificationsViewModel() -> NotificationsViewModel {
        NotificationsViewModel(fetchNotificationsUseCase: fetchNotificationsUseCase, markNotificationsReadUseCase: markNotificationsReadUseCase)
    }
    
    // MARK: - Init
    
    public init() {
        let env: AppEnvironment = .development
        self.config = AppConfiguration(environment: env)
        self.apiClient = APIClient(baseURL: env.apiBaseURL)
        self.router = AppRouter()
        
        // Initialize Repositories
        let propRepo = PropertyRepository()
        self.propertyRepository = propRepo
        
        let favRepo = FavoritesRepository()
        self.favoritesRepository = favRepo
        
        let searchRepo = SearchRepository(propertyRepository: propRepo)
        self.searchRepository = searchRepo
        
        let propDetailRepo = PropertyDetailRepository(propertyRepository: propRepo)
        self.propertyDetailRepository = propDetailRepo
        
        let chatRepo = ChatRepository()
        self.chatRepository = chatRepo
        
        let profileRepo = ProfileRepository()
        self.profileRepository = profileRepo
        
        let notifRepo = NotificationsRepository()
        self.notificationsRepository = notifRepo
        
        // Initialize Use Cases
        self.fetchPropertiesUseCase = FetchPropertiesUseCaseImpl(repository: propRepo)
        self.searchPropertiesUseCase = SearchPropertiesUseCaseImpl(repository: searchRepo)
        self.fetchFavoritesUseCase = FetchFavoritesUseCaseImpl(repository: favRepo)
        self.toggleFavoriteUseCase = ToggleFavoriteUseCaseImpl(repository: favRepo)
        self.fetchPropertyDetailUseCase = FetchPropertyDetailUseCaseImpl(repository: propDetailRepo)
        self.sendMessageUseCase = SendMessageUseCaseImpl(repository: chatRepo)
        self.fetchProfileUseCase = FetchProfileUseCaseImpl(repository: profileRepo)
        self.updateProfileUseCase = UpdateProfileUseCaseImpl(repository: profileRepo)
        self.fetchNotificationsUseCase = FetchNotificationsUseCaseImpl(repository: notifRepo)
        self.markNotificationsReadUseCase = MarkNotificationsReadUseCaseImpl(repository: notifRepo)
    }
}
