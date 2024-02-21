echo "###Get status cluster" >> PM_MFEC_$(date +%Y%m%d).txt
oc status >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get Cluster version" >> PM_MFEC_$(date +%Y%m%d).txt
oc get clusterversion >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get Node" >> PM_MFEC_$(date +%Y%m%d).txt
oc get no >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get Operation OpenShift" >> PM_MFEC_$(date +%Y%m%d).txt
oc get co >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get Pod DNS" >> PM_MFEC_$(date +%Y%m%d).txt
oc get pod -n openshift-dns -o wide >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get Pod Console" >> PM_MFEC_$(date +%Y%m%d).txt
oc get pod -n openshift-console -o wide >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get Pod Monitor" >> PM_MFEC_$(date +%Y%m%d).txt
oc get pod -n openshift-monitoring -o wide >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get Pod Ingress" >> PM_MFEC_$(date +%Y%m%d).txt
oc get pod -n openshift-ingress -o wide >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get CPU Node" >> PM_MFEC_$(date +%Y%m%d).txt
oc describe node | grep cpu >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get Mem Node" >> PM_MFEC_$(date +%Y%m%d).txt
oc describe node | grep mem >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get Top Node" >> PM_MFEC_$(date +%Y%m%d).txt
oc adm top node >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get ETCD Expire Date" >> PM_MFEC_$(date +%Y%m%d).txt
for each in $(oc get secret -n openshift-etcd | grep "kubernetes.io/tls" | grep -e "etcd-peer\|etcd-serving" | awk '{print $1}'); do oc get secret $each -n openshift-etcd -o jsonpath="{.data.tls\.crt}" | base64 -d | openssl x509 -noout -enddate >> PM_MFEC_$(date +%Y%m%d).txt; done
echo "###Get Ingress Expire Date" >> PM_MFEC_$(date +%Y%m%d).txt
oc get secret router-certs-default -o yaml -n openshift-ingress | grep crt | awk '{print $2}' | base64 -d | openssl x509 -noout -dates -issuer -subject >> PM_MFEC_$(date +%Y%m%d).txt
echo "###Get Ingress CA Expire Date" >> PM_MFEC_$(date +%Y%m%d).txt
oc get secret router-ca -o yaml -n openshift-ingress-operator |  grep crt | awk '{print $2}' | base64 -d | openssl x509 -noout -dates -issuer -subject >> PM_MFEC_$(date +%Y%m%d).txt
