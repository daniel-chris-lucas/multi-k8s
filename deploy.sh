docker build -t danielchrislucas/multi-client-k8s:latest -t danielchrislucas/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t danielchrislucas/multi-server-k8s-pgfix:latest -t danielchrislucas/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t danielchrislucas/multi-worker-k8s:latest -t danielchrislucas/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push danielchrislucas/multi-client-k8s:latest
docker push danielchrislucas/multi-server-k8s-pgfix:latest
docker push danielchrislucas/multi-worker-k8s:latest

docker push danielchrislucas/multi-client-k8s:$SHA
docker push danielchrislucas/multi-server-k8s-pgfix:$SHA
docker push danielchrislucas/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=danielchrislucas/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=danielchrislucas/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=danielchrislucas/multi-worker-k8s:$SHA