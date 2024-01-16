import PlaygroundSupport
import Foundation
import CoreLocation

let url = URL(string: "https://raw.githubusercontent.com/landrzejewski/bestweather-ios/main/data.json")!

/*
 Awaiting the async function pauses current execution and frees up the thread (it can be utilized for some other work). Once the async task is completed our original function can continue (not necessarily in the original thread). A regular function must be executed in one go, building up and unwinding its call stack uninterrupted, an asynchronous function does not have this limitation. It’s possible for Swift to take the call stack for an async function and put it aside for a while
 
 We can only call an async function only from a context that is already asynchronous e.g. using Task instance or task modifier (run on show, cancel on remove)
 
 Swift Concurrency ensures that there’s only a certain number of threads spawned in our application. It does this to prevent thread explosion
 
 Task can be created with one of three priorities;
 .userInitiated - default
 .tility
 .background
 */

// await Task.yield() // allow your function to temporarily give up its thread to allow other tasks to make some progress
// try await Task.sleep(for: .seconds(seconds)) // suspends thread for some time

//func fetchJson(url: URL) async -> String? {
//    do {
//        let (data, _) = try await URLSession.shared.data(from: url)
//        return String(bytes: data, encoding: .utf8)
//    } catch {
//        print("Error: \(error)")
//        return nil
//    }
//}

//Task {
//    if let json = await fetchJson(url: url) {
//        print(json)
//        await MainActor.run {
//            // update ui
//        }
//    } else {
//        print("Fetch failed")
//    }
//}
//
//func fetchJson(url: URL) async throws -> String? {
//    let (data, _) = try await URLSession.shared.data(from: url)
//    return String(bytes: data, encoding: .utf8)
//}
//
//Task {
//    if let json = try? await fetchJson(url: url) {
//        print(json)
//    } else {
//        print("Fetch failed")
//    }
//}

/*
 async let will make sure that the child tasks we create complete before our function returns even if we don’t explicitly aswait the result of our network calls. Using an async let will also make sure that cancellationis properly propagated from the parent task to the child tasks that we create
 When you define a property as async let,you can call an async function without awaiting that function immediately. Instead, you create a child task that will run the function you’re calling asynchronously.The function you’re calling with async let will start running immediately when the async let is created. Instead of awaiting the resul to the function call, execution resumes to the next line

 Up until now you have worked with unstructured and detached tasks. You already know that an unstructured task is created with Task {} and that an unstructured task inherits things like actors and task local values. You also know that you can create a detached task using Task.detached and that a detached task inherits nothing from its creation context.
 
 Neither of these tasks are child tasks of their creation context. Some of the most importantant differences between child tasks and unstructured/detached tasks are the following:
 
 • A child task is cancelled when its parent task is cancelled
 • A parent task cannot complete until its child tasks have completed (either successfully
 or with an error)
 • A cancelled parent task does not stop the child task. Cancellation between parent and
 child tasks is cooperative which means the child task must check for cancellation and
 explicitly respect the cancellation by stopping its work.
 • Priority,actors,and task local values are inherited from the parent task
 The most important rules to understand are the first two on that list. Cancelling a parent task will mark its children as cancelled, and a parent task cannot complete unless its child tasks are completed. This is fully unique to child tasks, and it’s what makes child tasks structured. We’ll dig into this a bit more once we get to the section on structured concurrency.
 The key reason to use an async let is almost never “I want a child task”. Having a child task is more of a result of wanting to perform work in a specific way than a result of literally wanting a child task to exist.
 In the example you saw earlier an async let made sense because:
 • We had two async function calls we wanted to await in parallel
 • The two async functions had no dependencies on each other
 • Our function logicallyc ouldn’t complete unless both async functions completed
 
*/

func getText(value: UInt64) async -> String {
    try? await Task.sleep(nanoseconds: value * 1000 * 1000 * 1000)
    return "abc"
}

//func fetchText() async throws -> [String] {
//     let text = await getText(value: 3)
//     print("After first")
//     let text2 = await getText(value: 10)
//     print("After second")
//     return [text, text2]
//}

//func fetchText() async throws -> [String] {
//     async let text = getText(value: 3)
//     print("After first")
//     async let text2 = getText(value: 10)
//     print("After second")
//     return [await text, await text2]
//}
//
//Task {
//    if let json = try? await fetchText() {
//        print("Done \(json.count)")
//    } else {
//        print("Fetch failed")
//    }
//}

// Async sequences

//func fetchAndPrint(url: URL) async throws {
//    for try await line in url.lines.filter({ entry in entry.count > 3 }) {
//        print("-----------------------------------------------------------------------------------")
//        print(line)
//    }
//}
//
//Task {
//    try? await fetchAndPrint(url: url)
//}

//struct IdGenerator: AsyncSequence, AsyncIteratorProtocol {
//    
//    typealias Element = Int
//    
//    private var counter = 1
//    
//    mutating func next() async throws -> Int? {
//        counter += 1
//        return counter
//    }
//    
//    func makeAsyncIterator() -> IdGenerator {
//        self
//    }
//    
//}
//
//Task {
//    let generator = IdGenerator()
//    for try await id in generator {
//        print(id)
//    }
//}

func makeStream(values: Int) -> AsyncStream<String> { // AsyncThrowingStream for throwing streams
    var valueCount = 0
    return AsyncStream(unfolding: {
        let value = await produceValue(shouldTerminate: valueCount == values)
        valueCount += 1
        return value
    }/*, onCancel: {
        // called upon cancellation
    }*/)
}

func produceValue(shouldTerminate: Bool) async -> String? {
    guard !shouldTerminate else {
        return nil
    }
    return UUID().uuidString
}

// A key difference between the unfolding closure and the continuation based approach is that the continuation gives us full control over how and when we produce values for our continuation.
// By default, all values that we we yield are buffered. This means that even though we immediately yield all values one after the other and then we complete the stream, anybody that chooses to iterate over our stream will receive all values that have been yielded before receiving the continuation.
 
//let stream = AsyncStream { continuation in
//    print("will start yielding")
//    continuation.yield(1)
//    continuation.yield(2)
//    continuation.yield(3)
//    continuation.finish()
//    print("finished the stream")
//}
//
//Task {
//    for await value in stream {
//        print("received \(value)")
//    }
//}

// When you’re only interested in the most recent n items that were sent by your AsyncStream, you can give it a buffering policy through its initializer:
// A buffering policy like this is useful when you want to make sure that you always receive the last yielded value (if any) before receiving any new values.
// You can also provide a buffering policy of bufferingNewest(0) which would discard any values that weren’t received by a for loop immediately. This could be a useful buffering policy for an async stream that yields values for events like when the user rotates their device or taps on a button. You’re usually only interested in these kinds of events as soon as they occur but once they’ve occurred they lose all relevance; you wouldn’t want to start iterating over a stream only to be told that the user rotated their device 5 minutes ago; you’ve probably already handled that rotation event somehow.
// It’s also possible to provide numbers other than zero or one for your buffering policy. You might be interested in getting the last four of five values from your stream instead. You can simply provide a number that fits your requirements and you’re good to go.
// In addition to buffering the newest values received by your stream, you can also use a bufferingOldest policy. This will keep the first n values that were not yet received by a for loop, and discard any new values that are received until space opens up in the buffer.
// In addition to the ability to buffer values, an AsyncStream allows us to keep a reference to our continuation outside of the closure that we pass to our AsyncStream initializer. This allows us to yield values for our stream from outside of the initializer. For example, we can yield values in response to certain delegate methods being called on an object that created an AsyncStream and stored the stream’s continuation in a property.

/*
let stream = AsyncStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
    print("will start yielding")
    continuation.yield(1)
    continuation.yield(2)
    continuation.yield(3)
    continuation.finish()
    print("finished the stream")
}
*/


class LocationProvider: NSObject {
  
    fileprivate let locationManager = CLLocationManager()
    
    fileprivate var continuation: AsyncStream<CLLocation>.Continuation?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    deinit {
        continuation?.finish()
    }
    
    func requestPermissionIfNeeded() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func startUpdatingLocation() -> AsyncStream<CLLocation> {
        requestPermissionIfNeeded()
        locationManager.startUpdatingLocation()
        return AsyncStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
            continuation.onTermination = { [weak self] _ in
                self?.locationManager.stopUpdatingLocation()
            }
            self.continuation = continuation }
    }
}

extension LocationProvider: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            continuation?.yield(location)
        }
    }
    
}

// Bridging combine to AsyncSequence
 
// func startUpdatingLocation() -> AsyncPublisher<AnyPublisher<CLLocation, Never>> {
//     requestPermissionIfNeeded()
//     locationManager.startUpdatingLocation()
//     return subject
//        .compactMap({ $0 })
//        .eraseToAnyPublisher()
//        .values  // returns swquence that allows iteration/access for many clients
// }

// Callbacks and async/await integration
// Always make sure that you complete your continuations at some point
// Ensure that you don’t complete your continuations more than once, and to ensure that your continuation doesn’t get deallocated without first resuming it which would cause any code that awaits your continuation to be hanging forever, and resources that are held on to by the continuation to be retained which would be a leak
// Use checked continuations during development but switch to unsafe continuations once you’re ready to deploy


//func fetchJson(url: URL, callback: @escaping (String?) -> ()) {
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        if let data = data {
//            callback(String(bytes: data, encoding: .utf8))
//        } else {
//            callback(nil)
//        }
//    }
//    .resume()
//}
//
//func fetchJsonAsync(url: URL) async -> String? {
//    // withCheckedThrowingContinuation
//    // withUnsafeContinuation
//    // withUnsafeThrowingContinuation
//    await withCheckedContinuation { continuation in
//        fetchJson(url: url) { continuation.resume(returning: $0) }
//    }
//}
//
//Task {
//    if let json = await fetchJsonAsync(url: url) {
//        print("Done \(json.count)")
//    } else {
//        print("Fetch failed")
//    }
//}

//func fetchJson(url: URL) async throws -> [String?] {
//    let firstTask = Task { () -> String? in
//        print("Start first task")
//        let (data, _) = try await URLSession.shared.data(from: url)
//        return String(bytes: data, encoding: .utf8)
//    }
//    let secondTask = Task { () -> String? in
//        print("Start second task")
//        let (data, _) = try await URLSession.shared.data(from: url)
//        return String(bytes: data, encoding: .utf8)
//    }
//    if !firstTask.isCancelled {
//        firstTask.cancel()
//    }
//    print("Before result")
//    return [try await firstTask.value, try await secondTask.value]
//}
//
//Task {
//    do {
//        let json = try await fetchJson(url: url)
//        print("Done \(json.count)")
//    }  catch {
//        print("Fetch failed \(error)")
//    }
//}


// Actors protect their mutable state by ensuring exclusive access to its members. Only one caller can access and mutate actor state at once (like locks but without blocking)
// By writing nonisolated func, we tell the compiler that our function can be called from a nonisolated context because it does not mutate the state
// let constants can freely be accessed from anywhere without an await

actor Account {
    
    var balace: Decimal
    let id = UUID().uuidString
    
    init(initialBalance: Decimal) {
        balace = initialBalance
    }
    
    func deposit(amount: Decimal) {
        balace += amount
    }
    
    func transfer(amount: Decimal, to other: Account) async {
        guard balace >= amount else {
            return
        }
        balace -= amount
        await other.deposit(amount: amount)
    }
    
    nonisolated func getId() -> String {
        id
    }
    
}

Task {
    let firstAccount = Account(initialBalance: 1000)
    let secondAccount = Account(initialBalance: 0)
    await firstAccount.deposit(amount: 200)
    await firstAccount.transfer(amount: 500, to: secondAccount)
    print("First account: \(await firstAccount.balace)")
    print("Second account: \(await secondAccount.balace)")
}

// When actor is suspended new caller can be serviced. Thats why we should always protect actors state
// The result of actor reentrancy is that any assumptions we make before an await should always be re-validated after an await


actor ImageLoader {
    
    private var imageData: [UUID: LoadingState] = [:]
    
    func loadImageData(using id: UUID) async throws -> Data {
        if let state = imageData[id] {
            switch state {
            case .loading(let task):
                return try await task.value
            case .completed(let data):
                return data
            }
        }
        
        let task = Task<Data, Error> {
            let url = URL(string: "baseUrl/\(id.uuidString)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        }
        
        imageData[id] = .loading(task)
        
        do {
            let data = try await task.value
            imageData[id] = .completed(data)
            return data
        } catch {
            imageData[id] = nil
            throw error
        }
    }
}

extension ImageLoader {
    enum LoadingState {
        case loading(Task<Data, Error>)
        case completed(Data)
    }
}


PlaygroundPage.current.needsIndefiniteExecution = true
