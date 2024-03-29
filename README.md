# Code Challenge

## The Problem

There are two distinct problems within this code challenge and both have to do
with navigating a directed graph while minimizing time complexity. The first
problem is returning the lowest common ancestor between two nodes. The second
problem is returning a list of birds for all provided nodes and their child
nodes.

## The Solution

Both problems require quick graph-traversal and list lookup so this solution
relies upon database indexes to achieve O(log n) lookup time when navigating
the graph, and O(log n) lookup time when searching for an item within a set.

The first problem can be solved by walking up the tree from the first node to
the root. The nodes are appended to an array (an ordered list to find depth)
and a ruby set (for quick lookup/comparison). Once the root node is reached,
the process begins walking up the tree for the second node. Each time it finds
the parent it checks if that node is included in the tree of the first node,
and exits when it finds a match. This method minimizes the total number of
graph lookups to the height of the tree from node a to the root plus the height
of the tree from node b to the lowest common ancestor.

The second problem of finding all children for a list of nodes (and subsequently
the related birds) can be solved by recursively asking "who are your children"
and returning all unique values when no more children are found. Then all birds
are returned with a SQL join query.

## Design

This code challenge was tackled in three parts:

1) A pure Ruby and Rspec project was created to solve the first problem and find
the lowest common ancestor for two nodes.

2) The project was then converted into a full Dockerized Rails application with
the required /common_ancestor endpoint.

3) Then, the in-memory data structures were converted to use an indexed
database, and the /birds endpoint was finished.

The final solution leverages a Ruby on Rails API, SQLite, Docker, Rspec, and
Faker. This challenge was completed in chunks when my free-time allowed.

## Getting Started

This application can be started via Docker by executing the command:

`./run app`

The test suite can be run via Docker with:

`./run test`

* *Note: Docker Desktop must be installed to use the `./run` commands.*

## Endpoints

### Common Ancestor

*Request*: GET `/common_ancestor?a=2138692&b=1045178`

*Example*:
```
  curl --header "Accept: application/json" \
    "http://localhost:3000/common_ancestor?a=2138692&b=1045178"
```

*Response*: json `{"root_id":1045177,"lowest_common_ancestor":1045178,"depth":2}`

<hr>

### Birds

*Request*: POST `/birds` json params `{ "node_ids": [ 2138692, 2138651, 1045178 ] }`

*Example*:
```
  curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"node_ids":[2138692,2138651,1045178]}' \
    "http://localhost:3000/birds"
```

*Response*: json `{"bird_ids":[1,2,3,5]}`

## Todo

This application is a proof-of-concept code-challenge, so many decisions were
made to reduce the scope and deliver a complete solution within the allotted
time. Here are the things that were considered but saved for later.

- [X] Provide descriptive errors for each endpoint
- [ ] Implement RuboCop for project linting
- [ ] Implement Simplecov for test coverage
- [ ] Implement a test watcher to run specs upon save
- [X] Create recursive SQL instead of ruby
