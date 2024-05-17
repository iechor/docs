#!/bin/sh
openssl genrsa -aes256 -out ca-key.pem 2048
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
openssl genrsa -out server-key.pem 2048
openssl req -subj "/CN=$HOST" -new -key server-key.pem -out server.csr
echo subjectAltName = IP:$YOUR_PUBLIC_IP > extfile.cnf
openssl x509 -req -days 365 -in server.csr -CA ca.pem -CAkey ca-key.pem       -CAcreateserial -out server-cert.pem -extfile extfile.cnf
openssl genrsa -out key.pem 2048
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
echo extendedKeyUsage = clientAuth > extfile.cnf
openssl x509 -req -days 365 -in client.csr -CA ca.pem -CAkey ca-key.pem       -CAcreateserial -out cert.pem -extfile extfile.cnf
rm -v client.csr server.csr
chmod -v 0400 ca-key.pem key.pem server-key.pem
chmod -v 0444 ca.pem server-cert.pem cert.pem
# iechor -d --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem       -H=0.0.0.0:7778
# iechor --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem       -H=$HOST:7778 version
mkdir -pv ~/.iechor
cp -v {ca,cert,key}.pem ~/.iechor
export IECHOR_HOST=tcp://$HOST:7778 IECHOR_TLS_VERIFY=1
# iechor ps
export IECHOR_CERT_PATH=~/.iechor/zone1/
# iechor --tlsverify ps
# curl https://$HOST:7778/images/json       --cert ~/.iechor/cert.pem       --key ~/.iechor/key.pem       --cacert ~/.iechor/ca.pem
