Como Instalar o Tekton no Cluster

Segue os próximos passos

1- Instalar o Tekton no Cluster

2- Instalar o Dashboard no Cluster

kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml

3- Instalar o Git Clone no Cluster
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.7/git-clone.yaml -n tekton


** Comando para alteração do storageclass **

kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

kubectl patch storageclass gold -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'


Depois de subir o código no github eu mudo para a branch main, atualizo ela e rodo aquele script que gera as imagens

Então, eu coloco a tag das versões nas imagens e dou um pull

Um com a tag e outro sem a tag para que a tag latest fique na versão mais atual mesmo