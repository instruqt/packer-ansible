# RHEL + latest EPEL

## Installing prerequisites
1. [Install packer](https://www.packer.io/docs/install)
2. [Install Google Cloud SDK](https://cloud.google.com/sdk/docs/install)

## Authenticate with Google Cloud
Packer uses the Application Default Credentials to connect with Google Cloud. 

Run this command to create the credentials and login with the correct account. 
```
gcloud auth application-default login
```

## Build and publish Compute Engine image
Replace [your-project] in the next snippet with the ID of the project we created for you (or your own project). 

```
export PROJECT=[your-project]
```

To build the new image, run this snippet
```
packer build -var project_id=$PROJECT ansible.pkr.hcl
```

## Verify
To check if the image is ready, run:
```
gcloud compute images list --project $PROJECT --no-standard-images
```

## Done!
