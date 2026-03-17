machine LoadBalancer {
    var numWorker: int;
    var workers: seq[Worker];


    start state Init {
        entry (input: (numberworker: int)) {
            var counter: int;
            numWorker = input.numberworker;
            counter = 0;
            while (counter < numWorker)
            {
                workers += (0, new Worker());
                counter = counter+1;
            }
            goto WorkingState;
        }
    }

    state WorkingState {
        on eClientTask do (task: tClientTask) {
            var target: Worker;
            var targetId: int;
            
            // randomly select a target
            targetId = choose(numWorker);
            target = workers[targetId];

            // send the request
            send target, eTask, (lb = this, id = targetId, client = task.client);
        }

        on eTaskResponse do (resp: tTaskResponse) {
            send resp.client, eClientResponse;
        }
    }
}