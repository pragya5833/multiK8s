docker build -t pragya5833/clientprod:latest -t pragya5833/clientprod:$SHA -f ./client/Dockerfile ./client
docker build -t pragya5833/serverprod:latest -t pragya5833/serverprod:$SHA -f ./server/Dockerfile ./server
docker build -t pragya5833/workerprod:latest -t pragya5833/workerprod:$SHA -f ./worker/Dockerfile ./worker
docker push pragya5833/clientprod:latest
docker push pragya5833/serverprod:latest
docker push pragya5833/workerprod:latest
docker push pragya5833/clientprod:$SHA
docker push pragya5833/serverprod:$SHA
docker push pragya5833/workerprod:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pragya5833/serverprod:$SHA
kubectl set image deployments/client-deployment client=pragya5833/clientprod:$SHA
kubectl set image deployments/worker-deployment worker=pragya5833/workerprod:$SHA