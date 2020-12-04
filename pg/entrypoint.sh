set -eux

echo "${EXTERNAL_IP} ${DOMAIN}" >> /etc/hosts
echo "${DOMAIN}" >> /etc/mailname

sed -i 's/USER@DOMAIN\.TLD/'"${MASTER}@${DOMAIN}"'/' /etc/postfix/aliases

postalias /etc/postfix/aliases

exec watchexec -r -p -w /etc -- 'service postfix restart 2>&1 \
                                ;service dovecot restart 2>&1
                                '


