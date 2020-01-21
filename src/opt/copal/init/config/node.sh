#!/bin/bash
cd $_target_/data/locals
echo "#!/bin/bash" > cluster.sh
#
NODE_NAME=$(hostname)
echo "NODE_NAME=$NODE_NAME" >> cluster.sh
#
i=0 && myips=($(hostname -I))
for ip in ${myips[@]}; do
  echo "[$i] $ip" && i=$((i+1))
done
read -p "Node IP: " i && NODE_IP=${myips[i]}
echo "NODE_IP=$NODE_IP" >> cluster.sh
unset ip && unset myips && unset i
#
read -p "Data Node? [Y/n]: " DATA_NODE
if [[ $DATA_NODE == "" || $DATA_NODE == "Y" || $DATA_NODE == "y" ]]; then 
  DATA_NODE=1 
else 
  DATA_NODE=0 
fi
echo "DATA_NODE=$DATA_NODE" >> cluster.sh
#
read -p "Application Node? [Y/n]: " APP_NODE
if [[ $APP_NODE == "" || $APP_NODE == "Y" || $APP_NODE == "y" ]]; then 
  APP_NODE=1 
else 
  APP_NODE=0 
fi
echo "APP_NODE=$APP_NODE" >> cluster.sh
