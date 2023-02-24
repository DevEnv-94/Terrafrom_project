# Credentials
%{ for i, dev in devs ~}
${i+1}: domain: ${domains[i].fqdn} ; login: ${dev.your_login} ; ip: ${ip_addrs[i].ipv4_address} ; password: ${passwords[i].result}
%{ endfor ~}