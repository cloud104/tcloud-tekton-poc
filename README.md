Como Instalar o Tekton no Cluster

Segue os próximos passos

1- Instalar o Tekton no Cluster

2- Instalar o Dashboard no Cluster

kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml

3- Instalar o Git Clone no Cluster
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.7/git-clone.yaml


** Comando para alteração do storageclass **

kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

kubectl patch storageclass gold -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
