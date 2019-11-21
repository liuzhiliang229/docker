#!/bin/bash
#Ver:  1.1
#DATE: 2019/11/20
#M.Liu
From_Ali(){
    echo -e "\033[1;34mkubernetes Version 1.16.3\033[0m"
    registry_url="registry.cn-beijing.aliyuncs.com/lad/lzl"
    ali_images=(
	  	kube-apiserver-v1.16.3
	  	kube-controller-manager-v1.16.3
	  	coredns-1.6.2
	  	etcd-3.3.15
	  	pause-3.1
	  	kube-proxy-v1.16.3
	  	kube-scheduler-v1.16.3
	       )
    k8s_images=(
    		k8s.gcr.io/pause:3.1
    		k8s.gcr.io/etcd:3.3.15-0
    		k8s.gcr.io/coredns:1.6.2
    		k8s.gcr.io/kube-controller-manager:v1.16.3
    		k8s.gcr.io/kube-scheduler:v1.16.3
    		k8s.gcr.io/kube-proxy:v1.16.3
    		k8s.gcr.io/kube-apiserver:v1.16.3
               )

    for i in ${ali_images[*]}
    do
        echo -e "\033[1;32m_________________________\033[0m"
        echo -e "\033[1;32mPull Image $i\033[0m"
        docker pull $registry_url:$i
        if [ $? -ne 0 ]
        then
            echo -e "\033[1;31m Pull Faild!Please Check Your Network!"
            exit
        fi
    done
        echo -e "\033[1;32m_________________________\033[0m"
        echo -e "\033[1;32mAdd Tag\033[0m"
        docker tag $registry_url:kube-apiserver-v1.16.3 k8s.gcr.io/kube-apiserver:v1.16.3
        docker tag $registry_url:kube-controller-manager-v1.16.3 k8s.gcr.io/kube-controller-manager:v1.16.3
        docker tag $registry_url:coredns-1.6.2 k8s.gcr.io/coredns:1.6.2
        docker tag $registry_url:etcd-3.3.15 k8s.gcr.io/etcd:3.3.15-0
        docker tag $registry_url:pause-3.1 k8s.gcr.io/pause:3.1
        docker tag $registry_url:kube-proxy-v1.16.3 k8s.gcr.io/kube-proxy:v1.16.3
        docker tag $registry_url:kube-scheduler-v1.16.3 k8s.gcr.io/kube-scheduler:v1.16.3
        
        echo -e "\033[1;32m_________________________\033[0m"
        echo -e "\033[1;32mRemove Old Tag\033[0m"
    for i in ${ali_images[*]}
    do
        docker rmi $registry_url:$i
    done
}

From_Class(){
    image_list=(
    10.30.5.120/docker/k8s.gcr.io/pause:3.1
    10.30.5.120/docker/k8s.gcr.io/etcd:3.3.15-0
    10.30.5.120/docker/k8s.gcr.io/coredns:1.6.2
    10.30.5.120/docker/k8s.gcr.io/kube-controller-manager:v1.16.3
    10.30.5.120/docker/k8s.gcr.io/kube-scheduler:v1.16.3
    10.30.5.120/docker/k8s.gcr.io/kube-proxy:v1.16.3
    10.30.5.120/docker/k8s.gcr.io/kube-apiserver:v1.16.3
    )
    echo -e "\033[1;34mkubernetes Version 1.16.3\033[0m"
    echo -e "\033[1;32mBegining______________________\033[0m"
    for i in ${image_list[*]}
    do
        echo -e "\033[1;32m_________________________\033[0m"
        echo -e "\033[1;32mPull $i\033[0m"
        docker pull $i
        if [ $? -ne 0 ]
        then
            echo -e "\033[1;31m Pull Faild!Please Check daemon.json!"
            exit
	else
	    echo -e "\033[1;32mOK~\033[0m"
        fi
        
        docker tag $i $(echo "$i" | awk -F '/' '{print $3"/"$4}')
        docker rmi $i
    done
}

echo -e "\033[1;32m_________________________\033[0m"
echo -e "\033[1;32m1.Pull images from Aliyun\n2.Pull images from Class\nq.exit\033[0m"
echo -e "\033[1;32m_________________________\033[0m"

read -ep "Chose:" chose

case $chose in
1)
  From_Ali
;;
2)
  From_Class   
;;
*)
  exit
esac
