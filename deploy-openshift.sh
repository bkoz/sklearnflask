#!/bin/bash

oc new-project model
oc new-app https://github.com/bkoz/sklearnflask -e APP_FILE=main.py
oc expose svc/sklearnflask
route=$(oc get route sklearnflask -o=custom-columns=HOST/PORT:.spec.host --no-headers)
echo "Wait a minute for pod to become ready..."
sleep 60
curl -d '[{"Age": 85, "Sex": "male", "Embarked": "S"}]' -H "Content-Type: application/json" -X POST http://${route}/predict
