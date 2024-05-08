### Multus setup

I'm going to add multus here as there are some k3s specifics. I'm going off the install from here: [k3s multus](https://docs.k3s.io/networking/multus-ipams)

```
helm install multus rke2-charts/rke2-multus -n kube-system --kubeconfig /etc/rancher/k3s/k3s.yaml --values values.yml
```
