test tcSingleWorkerV1 [main=SingleWorker]:
    assert CorrectnessInvariant in
    (union LoadBalancingModule, {SingleWorker});

test tcTwoWorkerV1 [main=TwoWorker]:
    assert CorrectnessInvariant in
    (union LoadBalancingModule, {TwoWorker});


test tcFourWorkerV1 [main=FourWorker]:
    assert CorrectnessInvariant in
    (union LoadBalancingModule, {FourWorker});

test tcSingleWorkerV2 [main=SingleWorkerV2]:
    assert CorrectnessInvariant in
    (union LoadBalancingModuleV2, {SingleWorkerV2});

test tcTwoWorkerV2 [main=TwoWorkerV2]:
    assert CorrectnessInvariant in
    (union LoadBalancingModuleV2, {TwoWorkerV2});

test tcFourWorkerV2 [main=FourWorkerV2]:
    assert CorrectnessInvariant in
    (union LoadBalancingModuleV2, {FourWorkerV2});

test tcSingleWorkerV3 [main=SingleWorkerV3]:
    assert CorrectnessInvariant in
    (union LoadBalancingModuleV3, {SingleWorkerV3});

test tcTwoWorkerV3 [main=TwoWorkerV3]:
    assert CorrectnessInvariant in
    (union LoadBalancingModuleV3, {TwoWorkerV3});

test tcFourWorkerV3 [main=FourWorkerV3]:
    assert CorrectnessInvariant in
    (union LoadBalancingModuleV3, {FourWorkerV3});