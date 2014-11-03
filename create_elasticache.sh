security_groupe_name=rds_sg
aws ec2 describe-security-groups --filter Name=group-name,Values=$security_groupe_name|grep VpcId|tr -d '"'|tr -d ','|tr -d ' '|cut -d ':' -f 2
