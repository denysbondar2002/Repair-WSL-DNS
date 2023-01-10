NAMESERVERS_LIST_FILE="/tmp/current_nameservers_list.txt"
powershell.exe "Get-DnsClientServerAddress -AddressFamily ipv4 | Select-Object -ExpandProperty ServerAddresses" > $NAMESERVERS_LIST_FILE
dos2unix $NAMESERVERS_LIST_FILE
sudo su -c '> /etc/resolv.conf'
cat $NAMESERVERS_LIST_FILE | while read nameserver
do
  sudo su -c "echo nameserver $nameserver >> /etc/resolv.conf"
done 
echo "WSL DNS fixed"
