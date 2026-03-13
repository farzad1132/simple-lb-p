
type tClientTask = (client: Client);
event eClientTask: tClientTask;

event eClientResponse;

machine Client {
    var numTasks: int;
    var lb: LoadBalancer;

    start state Init {
        entry (input: (numTasks: int, lb: LoadBalancer)) {
            numTasks = input.numTasks;
            lb = input.lb;
            SendTask();
            goto SendTasks;
        }
    }

    state SendTasks {
        on eClientResponse do {
            SendTask();
        }
    }

    fun SendTask() {
        if (numTasks == 0) {
            return;
        } else {
            numTasks = numTasks - 1;
            send lb, eClientTask, (client = this,);
        }
    }
}