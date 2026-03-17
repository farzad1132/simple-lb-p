machine LoadBalancerV3 {
    var numWorker: int;
    var workers: seq[Worker];
    var queue: seq[tClientTask];
    var workerQueues: map[int, int];

    start state Init {
        entry (input: (numberworker: int)) {
            var counter: int;
            numWorker = input.numberworker;
            counter = 0;
            while (counter < numWorker)
            {  
                workerQueues[counter] = 0;
                workers += (0, new Worker());
                counter = counter+1;
            }
            goto WorkingState;
        }
    }

    state WorkingState {
        on eClientTask do (task: tClientTask) {
            var targetId: int;
            targetId = FindIdle();
            if (targetId != -1) {

                SendTask(targetId, task.client);
            } else {
                // No idle worker, queue the request
                queue += (sizeof(queue), task);
            }
        }

        on eTaskResponse do (resp: tTaskResponse) {
            var popTask: tClientTask;
            send resp.client, eClientResponse;

            // If we have a task in the queue, send it to the newly idle worker
            if (sizeof(queue) > 0) {
                popTask = queue[0];
                queue -= (0);       // pop from queue
                SendTask(resp.id, popTask.client);
            } else {
                workerQueues[resp.id] = 0;  // mark worker as idle
            }
        }
    }

    fun FindIdle(): int {
        var key: int;
        foreach (key in keys(workerQueues))
        {
            if (workerQueues[key] == 0) {
                return key;
            }
        }
        return -1;
    }

    fun SendTask(target: int, client: Client) {
        var targetWorker: Worker;
        targetWorker = workers[target];
        workerQueues[target] = 1;  // mark worker as busy
        send targetWorker, eTask, (lb = this, id = target, client = client);
    }
}