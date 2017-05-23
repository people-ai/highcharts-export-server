# highcharts-export-server

## How to run in Kubernetes

Start deployment
```
kubectl run pai-highcharts-deployment --image=peopleai/highcharts
```

Expose deployment as a service
```
kubectl expose deployment pai-highcharts-deployment --name=pai-highcharts-service --port 3003
```
