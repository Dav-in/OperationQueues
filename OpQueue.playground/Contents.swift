import UIKit
import Foundation

struct OpQueue {

    func RunTasks() {
        let opQ = OperationQueue()
        let blockOp = BlockOperation()
        let blockOpTwo = BlockOperation()
        let blockOpThree = BlockOperation()

        blockOp.addExecutionBlock {
            print("This is Operation 1.")
        }

        blockOpTwo.addExecutionBlock {
            print("This is Operation 2.")
        }

        blockOpThree.addExecutionBlock {
            print("This is Operation 3.")
        }

        opQ.addOperation(blockOp)
        opQ.addOperation(blockOpTwo)
        opQ.addOperation(blockOpThree)
    }
}

let objTest = OpQueue()
objTest.RunTasks()

struct DelayOpOne {
    func syncDelayOne() {
        print("3 seconds for sync --------")
        Thread.sleep(forTimeInterval: 3)
        print("------- Sync was successful!")
        print("- Operation 1 completed -")
    }
}

struct DelayOpTwo {
    func syncDelayTwo() {
        print("3 seconds for sync --------")
        Thread.sleep(forTimeInterval: 3)
        print("------- Sync was successful!")
        print("- Operation 2 completed -")
    }
}

struct DelayOpThree {
    func syncDelayThree() {
        print("3 seconds for sync --------")
        Thread.sleep(forTimeInterval: 3)
        print("------- Sync was successful!")
        print("- Operation 3 completed -")
    }
}


struct SyncManager {
    
    func syncOfflineOps() {
        let delaySyncOne = BlockOperation()
        let delaySyncTwo = BlockOperation()
        let delaySyncThree = BlockOperation()

        
        delaySyncOne.addExecutionBlock {
            let delayOne = DelayOpOne()
            delayOne.syncDelayOne()
        }
        
        delaySyncTwo.addExecutionBlock {
        let delayTwo = DelayOpTwo()
            delayTwo.syncDelayTwo()
        }
        
        delaySyncThree.addExecutionBlock {
        let delayThree = DelayOpThree()
            delayThree.syncDelayThree()
        }
        
        delaySyncOne.addDependency(delaySyncTwo)
        delaySyncThree.addDependency(delaySyncOne)
        
        let operationQue = OperationQueue()
        operationQue.addOperation(delaySyncOne)
        operationQue.addOperation(delaySyncTwo)
        operationQue.addOperation(delaySyncThree)
    }
}

let syncObj = SyncManager()
syncObj.syncOfflineOps()


DispatchQueue.global().async {
    print("Task one identified")
}

DispatchQueue.global().async {
    print("Task two identified")
}


