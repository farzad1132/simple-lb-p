
type tTask = (lb: LoadBalancer, id: int, client: Client);
event eTask : tTask;
type tTaskResponse = (id: int, client: Client);
event eTaskResponse: tTaskResponse;

machine Worker {
    var queue: seq[tTask];
    var currentTask: tTask;
    var timer: Timer;

    start state Init {
        entry  {
            timer = CreateTimer(this);
            goto RecieveTask;
        }
    }

    state RecieveTask {
        on eTask do (task: tTask) {
            queue += (sizeof(queue), task);
            goto ProcessTask;
        } 
    }

    state ProcessTask {
        entry  {
            PopAndStart();
        }

        on eTimeOut do {
            send currentTask.lb, eTaskResponse, (id = currentTask.id,client = currentTask.client);
            if (sizeof(queue) == 0) {
                goto RecieveTask;
            } else {
                PopAndStart();
            }
        }

        on eTask do (task: tTask) {
            queue += (sizeof(queue), task);
        } 

    }

    fun PopAndStart() {
        // pop from the queue
        assert (sizeof(queue) > 0), "queue is empty";
        currentTask = queue[0];
        queue -= (0);

        // start the task processing (modeled with a Timer)
        StartTimer(timer);
    }
}