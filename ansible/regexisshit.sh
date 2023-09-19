cp /root/.ssh/authorized_keys /root/.ssh/authorized_keys.bak
cat /root/.ssh/authorized_keys.bak | awk -F '142\" ' '{print $2}' > /root/.ssh/authorized_keys
