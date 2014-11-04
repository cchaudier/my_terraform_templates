#!/bin/bash
init() {
  security_groupe_name=rds_sg
  client=cosmo
  engine=redis
  azone=eu-west-1a
  cache_node_type=cache.t2.micro
  vpc_id=$(aws ec2 describe-security-groups \
    --filter Name=group-name,Values=$security_groupe_name| \
    grep VpcId|tr -d '"'|tr -d ','|tr -d ' '|cut -d ':' -f 2)
  security_group_id=$(aws ec2 describe-security-groups \
    --filters Name=group-name,Values=$security_groupe_name| \
    grep GroupId|tr -d '"'|tr -d ','|tr -d ' '|cut -d ':' -f 2)
  subnet_ids=$(aws ec2 describe-subnets \
    --filter Name=vpc-id,Values=$vpc_id | \
    grep SubnetId|tr -d '"'|tr -d ','|tr -d ' '|cut -d ':' -f 2|tr '\n' ' ')
  cache_subnet_group_name="${client}-cache-subnet"
  cache_subnet_group_name="cache-subnet"
  cache_cluster_id="${client}-${engine}"
}

wip(){
  echo     "      - Work in progress "
  echo -n  "        "
  wip=1
  while [[ $wip -eq 1 ]]; do
    if [[ $1 == "cluster" ]]; then
      sleep 30
      aws elasticache describe-cache-clusters --out text| \
        grep $cache_cluster_id || wip=0
    elif [[ $1 == "subnet" ]]; then
      sleep 5
      aws elasticache describe-cache-subnet-groups \
        --cache-subnet-group-name $cache_subnet_group_name 2>/dev/null \
        grep $cache_subnet_group_name || wip=0
    fi
    echo -n "."
  done
  echo
  echo "      - Work done !"
}

create_cache_cluster() {
  echo "  => Create cache cluster"
  aws elasticache create-cache-cluster \
  --cache-cluster-id $cache_cluster_id \
  --preferred-availability-zone $azone \
  --cache-node-type $cache_node_type \
  --engine $engine \
  --num-cache-nodes 1 \
  --cache-subnet-group-name $cache_subnet_group_name \
  --security-group-ids $security_group_id
  wip cluster
}

create_cache_subnet() {
  echo "  => Create cache subnet"
  aws elasticache create-cache-subnet-group \
  --cache-subnet-group-name $cache_subnet_group_name \
  --cache-subnet-group-description "Subnet cache for $client" \
  --subnet-ids $subnet_ids 
  wip subnet
}

destroy_cache_cluster(){
  echo "  => Destroy cache cluster $cache_cluster_id"
  destroy_cache=0
  aws elasticache describe-cache-clusters --out text| \
    grep $cache_cluster_id \
    && destroy_cache=1 \
    || echo "      + Pas de cluster à détruire"
  if [[ $destroy_cache -eq 1 ]]; then
    aws elasticache delete-cache-cluster --cache-cluster-id $cache_cluster_id
    wip cluster
  fi
}

destroy_cache_subnet(){
  echo "  => Destroy cache subnet $cache_subnet_group_name"
  destroy_subnet=0
  aws elasticache describe-cache-subnet-groups \
    --cache-subnet-group-name $cache_subnet_group_name 2>/dev/null |\
    grep $cache_subnet_group_name \
    && destroy_subnet=1 \
    || echo "      + Pas de subnet à détruire"
  if [[ $destroy_subnet -eq 1 ]]; then
    aws elasticache delete-cache-subnet-group \
     --cache-subnet-group-name $cache_subnet_group_name
    wip subnet
  fi
}

trt_create() {
  echo "  => Create cache"
  create_cache_subnet
  create_cache_cluster
}

trt_destroy() {
  echo "  => Destroy cache"
  destroy_cache_cluster
  destroy_cache_subnet
}

if [[ $# -ne 1 ]]; then
  echo "Il faut au moin un argument !"
  exit 1
fi

init
trt_$1
