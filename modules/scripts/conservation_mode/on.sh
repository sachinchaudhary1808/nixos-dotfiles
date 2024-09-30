#!/usr/bin/env bash
echo 1 | pkexec tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004\:00/conservation_mode &&  notify-send "conservation_mode..on" 
