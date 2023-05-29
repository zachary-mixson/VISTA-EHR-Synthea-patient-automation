#!/usr/bin/env bash

user=$(whoami)

# Start Docker container
echo "Starting Synthea Docker container..."
sudo docker start synthea

# Remove Synthea patients
echo "Deleting previously generated Synthea patients..."
sudo docker exec -it synthea bash -c "rm -rf /synthea/synthea/output/*"
rm -rf /home/alexis/Desktop/VISTA-EHR-Synthea-patient-automation/json/fhir

# Generate new Synthea patients
echo "Generating Synthea patients in FHIR format..."
read -p "Enter desired population value: " population
sudo docker exec -it synthea bash -c "cd synthea/ && ./run_synthea -p ${population}"

# Copy Synthea patient records to project json directory
echo "Copying Synthea patients to json directory..."
docker cp synthea:/synthea/synthea/output/fhir /home/"$user"/Desktop/VISTA-EHR-Synthea-patient-automation/json

# Upload synthetic patient records to server
echo "Uploading Synthetic patients into VISTA-EHR system..."
cd /home/"$user"/Desktop/VISTA-EHR-Synthea-patient-automation
node index.js
