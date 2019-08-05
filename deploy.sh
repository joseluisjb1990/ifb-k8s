docker build -t joseluisjb1990/fib-fe:latest -t joseluisjb1990/fib-fe:$SHA -f ./client/Dockerfile ./client
docker build -t joseluisjb1990/fib-server:latest -t joseluisjb1990/fib-server:$SHA -f ./server/Dockerfile ./server
docker build -t joseluisjb1990/fib-worker:latest -t joseluisjb1990/fib-worker:$SHA -f ./worker/Dockerfile ./worker

docker push joseluisjb1990/fib-fe:latest
docker push joseluisjb1990/fib-server:latest
docker push joseluisjb1990/fib-worker:latest
docker push joseluisjb1990/fib-fe:$SHA
docker push joseluisjb1990/fib-server:$SHA
docker push joseluisjb1990/fib-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=joseluisjb1990/fib-server:$SHA
kubectl set image deployments/client-deployment client=joseluisjb1990/fib-fe:$SHA
kubectl set image deployments/worker-deployment worker=joseluisjb1990/fib-worker:$SHA
