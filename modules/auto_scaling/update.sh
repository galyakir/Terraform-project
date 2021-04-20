#!/bin/bash

#script arguments
ip=${ip}
url=${url}
id=${id}
secret=${secret}
host=${host}
password=${password}
key=${key}

#make password authentication
yes "$password" | sudo passwd ubuntu
sudo systemctl restart sshd

#change .env file to deploy the app
cd /home/ubuntu/node-weight-tracker || exit
echo "# Host configuration
PORT=8080
HOST=0.0.0.0
NODE_ENV=development
HOST_URL=http://$ip:8080
COOKIE_ENCRYPT_PWD=superAwesomePasswordStringThatIsAtLeast32CharactersLong!
# Okta configuration
OKTA_ORG_URL=https://$url
OKTA_CLIENT_ID=$id
OKTA_CLIENT_SECRET=$secret
# Postgres configuration
PGHOST=$host
PGUSERNAME=postgres
PGDATABASE=postgres
PGPASSWORD=postgres
PGPORT=5432" >.env
npm run initdb

#rest api request to update l ogin url at okta
curl --request PUT 'https://${url}/api/v1/apps/${id}' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: SSWS ${key}' \
--data-raw '{
    "name": "oidc_client",
    "label": "My Web App",
    "credentials": {
        "oauthClient": {
            "autoKeyRotation": true,
            "client_id": "${id}",
            "token_endpoint_auth_method": "client_secret_basic"
        }
    },
    "settings": {
        "oauthClient": {
            "redirect_uris": [
                "http://${ip}:8080/authorization-code/callback"
            ],
            "post_logout_redirect_uris": [
                "http://${ip}:8080/logout"
            ],
            "response_types": [
                "code"
            ],
            "application_type": "web",
            "consent_method": "TRUSTED",
            "issuer_mode": "ORG_URL"
        }
    }
}'
