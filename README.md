# GithubMVVM_CA
Swift MVVM Clean Architecture 

well-structured Swift MVVM Clean Architecture example using GitHub API. This example will:

✅ Follow Clean Architecture (Separation of Concerns)
✅ Use Combine for API calls
✅ Avoid Memory Leaks (Using [weak self] & proper cancellation)
✅ Support Multiple API Calls (Parallel & Sequential)
✅ Allow Cancellation of Requests

✅ Follow Clean Architecture (Separation of Concerns)
✅ Use Combine for API calls
✅ Avoid Memory Leaks (Using [weak self] & proper cancellation)
✅ Support Multiple API Calls (Parallel & Sequential)
✅ Allow Cancellation of Requests


🛠 API Details: GitHub Repositories

We’ll fetch repositories for a given username from GitHub’s public API:
👉 https://api.github.com/users/{username}/repos
📂 Project Structure

📂 Services/
   ├── APIClient.swift
   ├── GitHubService.swift
📂 Models/
   ├── GitHubRepo.swift
📂 Repositories/
   ├── GitHubRepository.swift
📂 ViewModels/
   ├── GitHubViewModel.swift
📂 Views/
   ├── GitHubViewController.swift

1️⃣ API Client - Handles Network Calls

This is our network layer that makes API requests using Alamofire and Combine.
APIClient.swift

2️⃣ Service Layer - Defines API Calls

We define GitHub API services using APIClient.
GitHubService.swift

3️⃣ Model - Define Data Structure

This represents a GitHub repository.
GitHubRepo.swift

4️⃣ Repository Layer - Business Logic

The repository acts as an intermediary between the service and the ViewModel.
GitHubRepository.swift

5️⃣ ViewModel - Handles API Calls & State

The ViewModel will:
✅ Manage API calls
✅ Store cancellables
✅ Handle loading states
✅ Prevent memory leaks
GitHubViewModel.swift

6️⃣ View (ViewController) - Display Data

Finally, the GitHubViewController listens to the ViewModel and displays data.
GitHubViewController.swift

🚀 Summary & Best Practices

✅ MVVM + Clean Architecture: Clear separation of concerns
✅ Combine for Async API Calls: AnyPublisher used
✅ Memory Management: Used [weak self] and .store(in: &cancellables)
✅ Multiple API Calls Supported: Can run multiple calls in parallel
✅ Error Handling: Gracefully handles network failures
✅ Cancel API Requests: cancelRequests() stops ongoing requests





