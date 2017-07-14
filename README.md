# AWS-getting-started
AWS Marketplace offer - getting started with BlockApps STRATO on AWS

## BlockApps STRATO instance on AWS marketplace
- On the AWS marketplace search for the keyword "blockapps" or "blockchain" and you'll find our listed offer (with a 5-day free trial edition).

*This individual STRATO instance (private blockchain node, self-contained and sufficient for prototyping and light POC's) provides a RESTful web API on the HTTP port for querying the blockchain and compiling and uploading contracts.*

### Steps to run STRATO Developer Edition using the AWS marketplace AMI

*All the setup is already done for you in the packaged AMI, just run the startup script to launch the platform services.*

- Step 1: Login to your AWS account or create one if you don't already have one.
- Step 2: Deploy a new EC2 instance from the BlockApps STRATO AMI, with at least 20 GB of space on the root volume.
- Step 3: SSH to your newly deployed node (user: ubuntu).
- Step 4: Run strato-admin script (takes about 10-20secs to see all docker containers running): 
```bash
$ ./strato-admin.sh --start
```

### Note: if the instance services do not come up within a minute, you can restart the services using:
```bash
./strato-admin.sh --stop 

./strato-admin.sh --start
```

*The single instance will provide the following (all on port 80):username: admin password: <ec2-instanceID>*
- The strato api -> http://[your server ip]/strato-api
- A bloc instance -> http://[your server ip]/bloc/v2.1
- A bloc explorer -> http://[your server ip]
- bloc API docs -> http://[your server ip]/bloc/v2.1/docs
- STRATO API docs -> http://[your server ip]/strato-api/eth/v1.2/docs
- Cirrus search -> http://[your server ip]/cirrus/search/

Once you've the instance up and running with the API's, you can also explore our demo-app here: https://github.com/blockapps/blockapps-ba 
