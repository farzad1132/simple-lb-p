type tConfig = (
    numWorker: int,
    numTasks: int,
    numClients: int
);

fun SetupLBSystem(config: tConfig) {
    var lb: LoadBalancer;
    var clients: set[Client];
    var i: int;

    announce eCorrectnessInitNWorker, config.numWorker;

    lb = new LoadBalancer((numberworker=config.numWorker,));

    i = 0;
    while (i < config.numClients)
    {
        clients += (new Client((numTasks=config.numTasks,lb=lb)));
        i = i+1;
    }
}

fun SetupLBSystemV2(config: tConfig) {
    var lb: LoadBalancer;
    var clients: set[Client];
    var i: int;

    announce eCorrectnessInitNWorker, config.numWorker;

    lb = new LoadBalancerV2((numberworker=config.numWorker,));

    i = 0;
    while (i < config.numClients)
    {
        clients += (new Client((numTasks=config.numTasks,lb=lb)));
        i = i+1;
    }
}

fun SetupLBSystemV3(config: tConfig) {
    var lb: LoadBalancer;
    var clients: set[Client];
    var i: int;

    announce eCorrectnessInitNWorker, config.numWorker;

    lb = new LoadBalancerV3((numberworker=config.numWorker,));

    i = 0;
    while (i < config.numClients)
    {
        clients += (new Client((numTasks=config.numTasks,lb=lb)));
        i = i+1;
    }
}

machine SingleWorker {
    start state Init {
        entry  {
            var config: tConfig;
            config = (numWorker=1, numTasks=2, numClients=3);
            SetupLBSystem(config);
        }
    }
}

machine TwoWorker {
    start state Init {
        entry  {
            var config: tConfig;
            config = (numWorker=2, numTasks=4, numClients=3);
            SetupLBSystem(config);
        }
    }
}

machine FourWorker {
    start state Init {
        entry  {
            var config: tConfig;
            config = (numWorker=4, numTasks=4, numClients=3);
            SetupLBSystem(config);
        }
    }
}

machine SingleWorkerV2 {
    start state Init {
        entry  {
            var config: tConfig;
            config = (numWorker=1, numTasks=2, numClients=3);
            SetupLBSystemV2(config);
        }
    }
}

machine TwoWorkerV2 {
    start state Init {
        entry  {
            var config: tConfig;
            config = (numWorker=2, numTasks=6, numClients=3);
            SetupLBSystemV2(config);
        }
    }
}

machine FourWorkerV2 {
    start state Init {
        entry  {
            var config: tConfig;
            config = (numWorker=4, numTasks=6, numClients=3);
            SetupLBSystemV2(config);
        }
    }
}

machine SingleWorkerV3 {
    start state Init {
        entry  {
            var config: tConfig;
            config = (numWorker=1, numTasks=2, numClients=3);
            SetupLBSystemV3(config);
        }
    }
}

machine TwoWorkerV3 {
    start state Init {
        entry  {
            var config: tConfig;
            config = (numWorker=2, numTasks=6, numClients=3);
            SetupLBSystemV3(config);
        }
    }
}

machine FourWorkerV3 {
    start state Init {
        entry  {
            var config: tConfig;
            config = (numWorker=4, numTasks=6, numClients=3);
            SetupLBSystemV3(config);
        }
    }
}