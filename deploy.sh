docker build -t danielchrislucas/multi-client:latest -t danielchrislucas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t danielchrislucas/multi-server:latest -t danielchrislucas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t danielchrislucas/multi-worker:latest -t danielchrislucas/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push daniel-chris-lucas/multi-client:latest
docker push daniel-chris-lucas/multi-server:latest
docker push daniel-chris-lucas/multi-worker:latest
docker push daniel-chris-lucas/multi-client:$SHA
docker push daniel-chris-lucas/multi-server:$SHA
docker push daniel-chris-lucas/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=danielchrislucas/multi-server:$SHA
kubectl set image deployments/client-deployment client=danielchrislucas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=danielchrislucas/multi-worker:$SHA