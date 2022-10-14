docker build -t jagoncalves/multi-client:latest -t jagoncalves/multi-client:$SHA ./client/Dockerfile ./client
docker build -t jagoncalves/multi-server:latest -t jagoncalves/multi-server:$SHA ./server/Dockerfile ./server
docker build -t jagoncalves/multi-worker:latest -t jagoncalves/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push jagoncalves/multi-client:latest
docker push jagoncalves/multi-server:latest
docker push jagoncalves/multi-worker:latest
docker push jagoncalves/multi-client:$SHA
docker push jagoncalves/multi-server:$SHA
docker push jagoncalves/multi-worker:$SHA
kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=jagoncalves/multi-client:$SHA
kubectl set image deployments/server-deployment server=jagoncalves/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jagoncalves/multi-worker:$SHA