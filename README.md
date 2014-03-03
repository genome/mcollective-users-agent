#Users Agent

An agent that can be used to list active users on remote machines.

##Installation

* Follow the [basic plugin install guide](http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/InstalingPlugins).

##Configuration

The Users client application can be configured to list active users.

##Usage
```

% mco users list --pattern mcall -I blade8-4-2.gsc.wustl.edu

 * [ ============================================================> ] 1 / 1

    blade8-4-2.gsc.wustl.edu mcallawa

    Summary of The User List:

       mcallawa = 1


       Finished processing 1 / 1 hosts in 152.21 ms

```
