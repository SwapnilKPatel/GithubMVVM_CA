# 🚀 Swift MVVM Clean Architecture Example (GitHub API)

A well-structured **Swift MVVM Clean Architecture** example using the GitHub API. This project follows best practices for **networking, memory management, and API handling**.

---

## ✨ Features  

✅ **Clean Architecture** (Separation of Concerns)  
✅ **MVVM Pattern** (Decoupled Business Logic & UI)  
✅ **Combine for API calls** (Reactive Programming)  
✅ **Memory Leak Prevention** (`[weak self]`, proper cancellation)  
✅ **Supports Multiple API Calls** (Parallel & Sequential Requests)  
✅ **API Request Cancellation** (Efficient resource management)  

---

## 🔗 **GitHub API Used**  
We fetch repositories for a given username using GitHub’s public API:  
👉 **`https://api.github.com/users/{username}/repos`**  

---

## 📂 **Project Structure**  

```
📂 Services/  
 ├── APIClient.swift         # Network Layer (Alamofire + Combine)  
 ├── GitHubService.swift     # API Endpoints  

📂 Models/  
 ├── GitHubRepo.swift        # Data Model  

📂 Repositories/  
 ├── GitHubRepository.swift  # Business Logic  

📂 ViewModels/  
 ├── GitHubViewModel.swift   # Handles API Calls & State  

📂 Views/  
 ├── GitHubViewController.swift  # UI (Displays Data)
```

---

## 🛠 **Architecture Breakdown**  

### **1⃣ API Client - Handles Network Calls**  
This is our **networking layer** that makes API requests using **Alamofire** and **Combine**.  
📌 **File:** `APIClient.swift`  

---

### **2⃣ Service Layer - Defines API Calls**  
Defines GitHub API services using `APIClient`.  
📌 **File:** `GitHubService.swift`  

---

### **3⃣ Model - Define Data Structure**  
Represents a GitHub repository model.  
📌 **File:** `GitHubRepo.swift`  

```swift
struct GitHubRepo: Codable {
    let id: Int
    let name: String
    let description: String?
    let stargazers_count: Int
}
```

---

### **4⃣ Repository Layer - Business Logic**  
Acts as an **intermediary** between the service and the ViewModel.  
📌 **File:** `GitHubRepository.swift`  

```swift
import Combine

protocol GitHubRepositoryProtocol {
    func fetchRepositories(for username: String) -> AnyPublisher<[GitHubRepo], APIError>
}

class GitHubRepository: GitHubRepositoryProtocol {
    private let service: GitHubServiceProtocol
    
    init(service: GitHubServiceProtocol = GitHubService()) {
        self.service = service
    }
    
    func fetchRepositories(for username: String) -> AnyPublisher<[GitHubRepo], APIError> {
        return service.getRepositories(username: username)
    }
}
```

---

### **5⃣ ViewModel - Handles API Calls & State**  
The ViewModel will:  
✅ Manage API calls  
✅ Store cancellables  
✅ Handle loading states  
✅ Prevent memory leaks  
📌 **File:** `GitHubViewModel.swift`  

```swift
import Combine

class GitHubViewModel: ObservableObject {
    @Published var repos: [GitHubRepo] = []
    @Published var loadingState: LoadingState = .idle
    private var cancellables = Set<AnyCancellable>()
    
    private let repository: GitHubRepositoryProtocol

    init(repository: GitHubRepositoryProtocol = GitHubRepository()) {
        self.repository = repository
    }
    
    func fetchRepos(for username: String) {
        loadingState = .loading
        repository.fetchRepositories(for: username)
            .receive(on: DispatchQueue.main) // Ensure UI updates on the main thread
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.loadingState = .failed(error.localizedDescription)
                case .finished:
                    self.loadingState = .success
                }
            } receiveValue: { repos in
                self.repos = repos
            }
            .store(in: &cancellables) // Prevent memory leaks
    }
}
```

---

### **6⃣ View (ViewController) - Display Data**  
The `GitHubViewController` listens to the ViewModel and updates the UI accordingly.  
📌 **File:** `GitHubViewController.swift`  

```swift
import UIKit
import Combine

class GitHubViewController: UIViewController {
    private var viewModel = GitHubViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.fetchRepos(for: "apple") // Fetch Apple's GitHub repos
    }
    
    private func setupBindings() {
        viewModel.$repos
            .receive(on: DispatchQueue.main)
            .sink { repos in
                print("Fetched \(repos.count) repos") // Update UI
            }
            .store(in: &cancellables)
    }
}
```

---

## 🚀 **Summary & Best Practices**  

✅ **MVVM + Clean Architecture** → Clear separation of concerns  
✅ **Combine for Async API Calls** → Uses `AnyPublisher`  
✅ **Memory Management** → Uses `[weak self]` & `.store(in: &cancellables)`  
✅ **Supports Multiple API Calls** → Runs parallel API requests  
✅ **Error Handling** → Gracefully manages API failures  
✅ **API Request Cancellation** → `cancelRequests()` stops ongoing requests  

---

## 📌 **Setup Instructions**  

### **🔹 Step 1: Clone the Repository**  
```bash
git clone https://github.com/your-username/GitHubMVVM_CleanArchitecture.git
cd GitHubMVVM_CleanArchitecture
```

### **🔹 Step 2: Install Dependencies (Alamofire, Combine)**  
```bash
pod install
```

### **🔹 Step 3: Open in Xcode & Run**  
```bash
open GitHubMVVM_CleanArchitecture.xcworkspace
```

---

## 🌟 **Like This Project? Give it a ⭐ on GitHub!**

