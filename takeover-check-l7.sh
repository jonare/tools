#!/bin/bash

if [[ -f $1 ]]; then
  dir=$1
else
  dir="output"
fi

declare -a fingerprints=(
                "If this is your website and you've just created it, try refreshing in a minute"
                "The specified bucket does not exist"
                "Repository not found"
                "Trying to access your account?"
                "404: This page could not be found."
                "The thing you were looking for is no longer here, or never was"
                "There isn't a Github Pages site here"
                "404 Blog is not found"
                "We could not find what you're looking for"
                "No settings were found for this company"
                "Uh oh. That page doesn't exist"
                "is not a registered InCloud YouTrack"
                "No Site For Domain"
                "a wrong turn somewhere. Don't worry...it happens to all of us."
                "Tunnel *.ngrok.io not found"
                "404 error unknown site!"
                "Sorry, couldn't find the status page"
                "Project doesnt exist... yet!"
                "This job board website is either expired or its domain name is invalid."
                "project not found"
                "Non-hub domain, The URL you've accessed does not provide a hub."
                "This UserVoice subdomain is currently available!"
                "Do you want to register *.wordpress.com?"
                "Hello! Sorry, but the website you"
                )

for i in "${fingerprints[@]}"; do
   grep -lhr -F "$i" "$dir/" && echo -e "\e[1;32mSUBDOMAIN TAKEOVER MAY BE POSSIBLE!\e[0m Pattern: $i. See https://github.com/EdOverflow/can-i-take-over-xyz"
done