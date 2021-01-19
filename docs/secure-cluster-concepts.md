# Secure Cluster Concepts
The Secure Cluster is as mentioned a part of the Operations as a Service for kubernetes. It is a "shift-left" approach for development for security and operations.

It consists of what has been coined as:
 - secure cluster
 - secure namespace

The basic idea is to have a "cluster namespace" aka "secure cluster" where the commonalities for every namespace used for applications and services. The common namespace is currently named "netic-oaas-system" as default and is default setup using flux. This "cluster namespace" is also used to create the "application and service namespaces" one at the time. 
Each of these "application and service namespaces" are created with sensible defaults for the namespace amongst these are e.g.:
- ressource limits
- network policies
- access control 



