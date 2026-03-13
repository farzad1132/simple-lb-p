# Simple Load balancing policies with P

In this toy project, I have implemented three simple load bala cing policies along with a simple correctness for educational purposes (myself included!).
The sole purpose of this project is to show how easy it is to explore different design ideas quickly without getting into implementation details.

## Modeling

### Clients

Each client sends a request when it gets a response previously sent request. Therefore, having $N$ clients means that we will have $N$ **concurrent** requests in the system.

### Workers

Each worker has a FIFO queue and processes requests with run-to-completion scheduling. Only one request can be in process at any given time.

### Load balancer

Load balancer intercepts client requests and decides which worker to forward the request to. In this project, I have implemented three load balancing polciies:
1. Random
2. Join Shorted Queue (JSQ)
3. Single queue late binding: In this policy, load balancer does not queue requests in workers. Instead, whenever all workers are busy, requests are queued up in the load balancer itself. A request is poped from the queue whenever one of the workers finish processing a request.


## Correctness Specification

I have implemented a single safety condition that passes only if the lpolicy is **work conserving**. This condition is violated if there are any requests waiting in a queue while a worker is idle.