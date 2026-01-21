NODES="kubmas1-1 kubwor1-1 kubwor1-2 kubwor1-3 kubmas2-1 kubwor2-1 kubwor2-2"
openssl s_client -showcerts -connect dockreg.labs.lod.netapp.com:443 </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > netapp-reg.crt
for NODE in $NODES; do 
scp netapp-reg.crt root@$NODE:/usr/local/share/ca-certificates/netapp-registry.crt
ssh root@$NODE "update-ca-certificates &&  systemctl restart containerd"
done;
