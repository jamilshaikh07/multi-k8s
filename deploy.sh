docker build -t jamilshaikh07/multi-client:latest -t jamilshaikh07/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jamilshaikh07/multi-server:latest -t jamilshaikh07/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jamilshaikh07/multi-worker:latest -t jamilshaikh07/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jamilshaikh07/multi-client:latest
docker push jamilshaikh07/multi-server:latest
docker push jamilshaikh07/multi-worker:latest

docker push jamilshaikh07/multi-client:$SHA
docker push jamilshaikh07/multi-server:$SHA
docker push jamilshaikh07/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jamilshaikh07/multi-server:$SHA
kubectl set image deployments/server-deployment client=jamilshaikh07/multi-client:$SHA
kubectl set image deployments/server-deployment worker=jamilshaikh07/multi-worker:$SHA
