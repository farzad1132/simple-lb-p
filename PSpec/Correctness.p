event eCorrectnessInitNWorker: int;

spec CorrectnessInvariant observes eTask, eTaskResponse, eCorrectnessInitNWorker {
    var queueSizes: map[int, int];
    var numWorker: int;

    start state Init {
        on eCorrectnessInitNWorker do (n: int) {
            var counter: int;
            numWorker = n;
            counter = 0;
            while (counter < n)
            {
                queueSizes[counter] = 0;
                counter = counter+1;
            }
            goto WaitForEvents;
        }
    }

    state WaitForEvents {
        on eTask do (task: tTask) {
            queueSizes[task.id] = queueSizes[task.id] + 1;
        }

        on eTaskResponse do (resp: tTaskResponse) {
            var counter: int;
            assert (queueSizes[resp.id] > 0), 
            format("Invalid response. Queue of worker {0} was emptry", resp.id);

            queueSizes[resp.id] = queueSizes[resp.id] - 1;

            /*
            If the queue of this worker is empty, then the queue of all workers should be emptry
            */
            if (queueSizes[resp.id] == 0) {
                counter = 0;
                while (counter < numWorker)
                {   
                    if (resp.id != counter) {
                        assert (queueSizes[counter] <= 1), 
                        format("Worker {0} is idle while Worker {1} has {2} tasks queued",
                        resp.id, counter, queueSizes[counter]-1);
                    }
                    counter = counter+1;
                }
            }
        }
    }
}