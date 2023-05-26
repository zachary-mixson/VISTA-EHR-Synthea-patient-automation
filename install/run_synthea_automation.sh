#!/usr/bin/env bash

user=$(whoami)

# Start Docker container
echo "Starting Synthea Docker container..."
sudo docker start synthea

# Generate Synthea patients
echo "Generating Synthea patients in FHIR format..."
read -p "Enter desired population value: " population
sudo docker exec -it synthea bash -c "cd synthea/ && ./run_synthea -p ${population}"

# Copy Synthea patient data to project json directory
echo "Copying Synthea patients to json directory..."
docker cp synthea:/synthea/synthea/output/fhir /home/"$user"/Desktop/VISTA-EHR-Synthea-patient-automation/json

echo "Uploading Synthetic patients into VISTA-EHR system..."
cd /home/alexis/Desktop/VISTA-EHR-Synthea-patient-automation
node index.js
