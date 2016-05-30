#!/usr/bin/env python

import botocore.session
import boto3
import json

# Load data form data.json file in the same directory
with open('data.json') as json_data:
  data = json.load(json_data)
  json_data.close()

# Read all data to locals
profile_name = data['profile_name']
region_name = data['region_name']
resources = data['resources']
tags = data['tags']
dry_run = data['dry_run?']

# Tell Boto 3 to use that session by default
boto3.setup_default_session(profile_name=profile_name ,region_name=region_name)

# Now create a resource
client = boto3.client('ec2')

response = client.create_tags(
  DryRun=dry_run,
  Resources=resources,
  Tags=tags
)

print json.dumps(response)