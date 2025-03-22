# chef_applications

Installation of Application using Chef and applying STIG compliance standards

## Setup

### Vagrant Redhat Credentials:

<https://www.redhat.com/en>

```
$env:REDHAT_USERNAME='username'
$env:REDHAT_PASSWORD='password'
```

### AWS Createndiatls:

1. Sign in to AWS Console

Go to: <https://console.aws.amazon.com/iam/>

2. Navigate to your IAM User

Click "Users" in the left menu
Click your username

3. Go to the "Security Credentials" tab

Scroll down to “Access Keys”
Click “Create access key”

4. Select Access Type

Choose "Command Line Interface (CLI), SDK, & other development tools", then click Next.

5. Download or Copy Keys

You’ll now be shown:

Access Key ID
Secret Access Key

## Run

```
./kitchen.sh list
./kitchen.sh converge
./kitchen.sh verify
./kitchen.sh destroy
```

### AWS Instances

https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#Instances: