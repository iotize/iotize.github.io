---
title: Simplifying completion callbacks
date: 2020-05-21 22:30
tags: Swift
---

# Simplifying completion callbacks

It’s commonplace in asynchronous Swift code to have a method return a `Result` type as an argument to a completion callback. If one of those asynchronous methods calls another, it can require disambiguating the returned `Result` both in the intermediary layer and at the final call site:

```
struct RegistrationService {
    let marketingPreferencesService: MarketingPreferencesService
    
    func register(email: String, password: String, subscribe: Bool, completion: @escaping (Result<User, Error>) -> Void) {
        // register the user
        var user = User(email: email)
        
        // if the user didn't want to subscribe, return early
        if !subscribe {
            return completion(.success(user))
        }
        
        // if the user did want to subscribe, sign 'em up
        marketingPreferencesService.subscribe(email: email) { result in
            switch result {
                case .success:
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

let service = RegistrationService(marketingPreferencesService: MarketingPreferencesService())
service.register(email: "ryan@website.com", password: "password", subscribe: true) { result in
    switch result {
    case .success(let user):
        print(user)
    case .failure(let error):
        print(error)
    }
}
```

In this small example, there are only two switch statements for dealing with the `Result` type, but in a typical project there could be many types like these that all rely on each other, and that can quickly add up to a whole lot of `Result` wrangling.

The final call site would typically have unique behaviour and is harder to generalise. The intermediary calls, though, have a similar pattern. In this case, the call from `RegistrationService` to `marketingPreferencesService`:

- Calls the original completion with a different value if the request is successful.
- Passes the error through to the original completion if the request fails.

This logic can be extracted into a reusable function and used in each service that follows this pattern:

```
func replaceSuccess<Success, NewSuccess, Failure>(with newSuccess: NewSuccess, completion: @escaping (Result<NewSuccess, Failure>) -> Void) -> (Result<Success, Failure>) -> Void {
    { result in
        switch result {
            case .success:
                completion(.success(newSuccess))
            case .failure(let error):
                completion(.failure(error))
        }
    }
}
```

This function:

1. Has two arguments: the first is the value to use for replacing in case of success, and the second is the completion we want to call with the new success or failure when this function is called.
2. Returns the same closure type as is expected for any completion callback: it takes a `Result` and returns `Void`.

The switch statement in `RegistrationService` can be replaced with:

```
marketingPreferencesService.subscribe(email: email, completion: replaceSuccess(with: user, completion: completion))
```

Any other types with a similar approach – in this case, ones that rely on a second asynchronous call for which the result should be ignored – can use the same function. This reduces the amount of code needed, which is a nice improvement, but more importantly it helps to make the approach consistent throughout the codebase.