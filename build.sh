result=$(terraform apply --auto-approve | grep 'instance_public =' | awk -F\" '{print $2}')
echo $result

sed -i "s/<ip>/$result/g" ./ansible/vpn/inventory.ini
sed -i "s/<ip>/$result/g" ./ansible/vpn/vpn.yml
