machine LoadBalancerV2 {
    var numWorker: int;
    var workers: seq[Worker];
    var queueSize: map[int, int];


    start state Init {
        entry (input: (numberworker: int)) {
            var counter: int;
            numWorker = input.numberworker;
            counter = 0;
            while (counter < numWorker)
            {
                workers += (0, new Worker());
                queueSize[counter] = 0;
                counter = counter+1;
            }
            goto WorkingState;
        }
    }

    state WorkingState {
        on eClientTask do (task: tClientTask) {
            var target: Worker;
            var targetId: int;
            
            targetId = FindMin();
            target = workers[targetId];
            queueSize[targetId] = queueSize[targetId] + 1;
            send target, eTask, (lb = this, id = targetId, client = task.client);
        }

        on eTaskResponse do (resp: tTaskResponse) {
            queueSize[resp.id] = queueSize[resp.id] - 1;
            send resp.client, eClientResponse;
        }
    }

    fun FindMin(): int {
        var minKey: int;
        var min: int;
        var key: int;
        min = queueSize[0];
        foreach (key in keys(queueSize))
        {
            if (queueSize[key] < min) {
                minKey = key;
                min = queueSize[key];
            }
        }
        return minKey;
    }
}