# Sample Retrieve Kubernetes Node Statistics

This guidebook will emit a stream of samples of the form:

```
NAME                           GPUCapacity   GPUFree   CPUCapacity   CPUFree   MemoryCapacity   MemoryFree   Type
ip-10-0-131-199.ec2.internal   <none>        <none>    2             1500m     8149576Ki        6998600Ki    m4.large
ip-10-0-131-59.ec2.internal    <none>        <none>    4             3500m     16407104Ki       15256128Ki   m4.xlarge
ip-10-0-138-205.ec2.internal   1             1         8             7500m     62855724Ki       61704748Ki   p3.2xlarge
ip-10-0-141-246.ec2.internal   1             1         8             7500m     62855724Ki       61704748Ki   p3.2xlarge
ip-10-0-142-209.ec2.internal   1             1         8             7500m     62855724Ki       61704748Ki   p3.2xlarge
ip-10-0-142-49.ec2.internal    1             1         8             7500m     62855724Ki       61704748Ki   p3.2xlarge
ip-10-0-154-249.ec2.internal   <none>        <none>    2             1500m     8149576Ki        6998600Ki    m4.large
ip-10-0-158-5.ec2.internal     <none>        <none>    4             3500m     16407108Ki       15256132Ki   m4.xlarge
ip-10-0-167-175.ec2.internal   <none>        <none>    2             1500m     8149572Ki        6998596Ki    m4.large
ip-10-0-169-105.ec2.internal   <none>        <none>    4             3500m     16407108Ki       15256132Ki   m4.xlarge
```

```shell.async
--8<-- "./node-stats.sh"
```
