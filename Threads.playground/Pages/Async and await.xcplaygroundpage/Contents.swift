import PlaygroundSupport
import Foundation

let url = URL(string: "https://raw.githubusercontent.com/landrzejewski/")!

/*
 Awaiting the async function pauses current execution and frees up the thread (it can be utilized for some other work). Once the async task is completed our original function can continue (not necessarily in the original thread). A regular function must be executed in one go, building up and unwinding its call stack uninterrupted, an asynchronous function does not have this limitation. It’s possible for Swift to take the call stack for an async function and put it aside for a while
 
 We can only call an async function only from a context that is already asynchronous e.g. using Task instance or task modifier (run on show, cancel on remove)
 
 Swift Concurrency ensures that there’s only a certain number of threads spawned in our application. It does this to prevent thread explosion
 
 Task can be created with one of three priorities;
 .userInitiated - default
 .tility
 .background
 */


PlaygroundPage.current.needsIndefiniteExecution = true
