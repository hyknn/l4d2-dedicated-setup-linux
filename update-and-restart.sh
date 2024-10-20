#!/bin/bash

# Check if the file exists
if [ -f "workshop.py" ]; then
    # Check if the file is executable
    if [ -x "workshop.py" ]; then
        echo "workshop.py is already executable."
    else
        # Make the file executable
        sudo chmod +x "./workshop.py"
        echo "Executable permissions added to workshop.py"
    fi

    # Check if /addons/workshop/ directory exists
    if [ ! -d "addons/workshop" ]; then
        # Create the directory if it doesn't exist
        echo "Directory addons/workshop/ not found. Creating it now..."
        mkdir -p addons/workshop
        echo "Directory addons/workshop/ created."
    else
        # Remove files in /addons/workshop/ directory if it exists
        echo "Removing files in addons/workshop/..."
        rm -rf addons/workshop/*
        echo "Files in addons/workshop/ removed."
    fi

    # Update workshop
    echo "Updating workshop with ID 3351861747"
    ./workshop.py -o addons/workshop 3351861747
    echo "Updating workshop with ID 3352114089"
    ./workshop.py -o addons/workshop 3352114089
    echo "Workshop files updated successfully."

    # Restart container
    echo "Restarting Docker container..."
    sudo docker compose restart
    echo "Docker container restarted successfully."

else
    echo "workshop.py not found. Please ensure the file exists."
fi
