docker build -t jarekjaro/multi-client:latest -t jarekjaro/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jarekjaro/multi-server:latest -t jarekjaro/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jarekjaro/multi-worker:latest -t jarekjaro/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jarekjaro/multi-client:latest
docker push jarekjaro/multi-server:latest
docker push jarekjaro/multi-worker:latest

docker push jarekjaro/multi-client:$SHA
docker push jarekjaro/multi-server:$SHA
docker push jarekjaro/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jarekjaro/multi-client:$SHA
kubectl set image deployments/server-deployment server=jarekjaro/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jarekjaro/multi-worker:$SHA