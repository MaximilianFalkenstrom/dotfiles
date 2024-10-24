#!/bin/bash

# Sleep for 0.2 seconds after killing polybar to prevent the new polybar being opened before kill is completed
sleep .2

polybar --reload example &