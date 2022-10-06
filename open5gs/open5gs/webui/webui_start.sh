#!/bin/bash
export DB_URI="mongodb://${MONGO_IP}/open5gs"
export HOSTNAME=${OPEN5GS_WEBUI_IP}
cd webui
npm run dev
