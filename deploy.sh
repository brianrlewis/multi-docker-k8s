docker build -t brlewis23/multi-docker-client:latest -t brlewis23/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t brlewis23/multi-docker-server:latest -t brlewis23/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t brlewis23/multi-docker-worker:latest -t brlewis23/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push brlewis23/multi-docker-client:latest
docker push brlewis23/multi-docker-server:latest
docker push brlewis23/multi-docker-worker:latest

docker push brlewis23/multi-docker-client:$SHA
docker push brlewis23/multi-docker-server:$SHA
docker push brlewis23/multi-docker-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=brlewis23/multi-docker-client:$SHA
kubectl set image deployments/server-deployment server=brlewis23/multi-docker-server:$SHA
kubectl set image deployments/worker-deployment worker=brlewis23/multi-docker-worker:$SHA