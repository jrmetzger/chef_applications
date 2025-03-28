# chef_applications

Installation of Application using Chef and applying STIG compliance standards

## Supports

Amazon Linux 2023
Redhat Enterprise 9
Ubuntu 22.04

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

6. Set Environment Variables

```
$env:AWS_ACCESS_KEY_ID='AWS_ACCESS_KEY_ID'
$env:AWS_SECRET_ACCESS_KEY='AWS_SECRET_ACCESS_KEY'
```

* https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#KeyPairs:

```
$env:AWS_SSH_KEY_NAME='AWS_SSH_KEY_NAME'
```

* https://us-east-1.console.aws.amazon.com/vpcconsole/home?region=us-east-1#subnets:

```
$env:SUBNET_ID='SUBNET_ID'
```

* https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#AMICatalog

```
$env:IMAGE_ID='IMAGE_ID'
$env:INSTANCE_TYPE='INSTANCE_TYPE'
```

* https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#SecurityGroups:
```
$env:SECURITY_GROUP_ID='SECURITY_GROUP_ID'
```

### AWS Mount

Step 1: Create a New EBS Volume

Go to the AWS Console → Navigate to EC2.
On the left panel, select Volumes (under "Elastic Block Store").
Click Create Volume:
Volume Type: gp3 (Recommended) or gp2.
Size: Choose the appropriate size (e.g., 10GB).
Availability Zone: Select the same AZ as your EC2 instance!
Encryption: Optional (recommended for security).
Click Create Volume.

Step 2: Attach the Volume to Your Instance

In the Volumes page, select your newly created volume.
Click Actions → Attach Volume.
Choose your EC2 instance.
Note the device name assigned (e.g., /dev/xvdf or /dev/nvme1n1).
Click Attach.

## Run

```
$ ./kitchen.sh create rhel9
$ ./kitchen.sh converge rhel9
$ ./kitchen.sh verify rhel9
$ ./kitchen.sh destroy rhel9
```

```
$ ./kitchen.sh help
Commands:
  kitchen console                                 # Test Kitchen Console!
  kitchen converge [INSTANCE|REGEXP|all]          # Change instance state to converge. Use a provisioner to configure one or more instances
  kitchen create [INSTANCE|REGEXP|all]            # Change instance state to create. Start one or more instances
  kitchen destroy [INSTANCE|REGEXP|all]           # Change instance state to destroy. Delete all information for one or more instances
  kitchen diagnose [INSTANCE|REGEXP|all]          # Show computed diagnostic configuration
  kitchen doctor INSTANCE|REGEXP                  # Check for common system problems
  kitchen exec INSTANCE|REGEXP -c REMOTE_COMMAND  # Execute command on one or more instance
  kitchen help [COMMAND]                          # Describe available commands or one specific command
  kitchen init                                    # Adds some configuration to your cookbook so Kitchen can rock
  kitchen list [INSTANCE|REGEXP|all]              # Lists one or more instances
  kitchen login INSTANCE|REGEXP                   # Log in to one instance
  kitchen package INSTANCE|REGEXP                 # package an instance
  kitchen setup [INSTANCE|REGEXP|all]             # Change instance state to setup. Prepare to run automated tests. Install busser and related gems on one or more instances
  kitchen test [INSTANCE|REGEXP|all]              # Test (destroy, create, converge, setup, verify and destroy) one or more instances
  kitchen verify [INSTANCE|REGEXP|all]            # Change instance state to verify. Run automated tests on one or more instances
  kitchen version                                 # Print Test Kitchen's version information
```

Destroy, Converge and Verify (test)
```
$ ./kitchen dv INSTANCE|REGEXP
```

Converge and Verify
```
$ ./kitchen cv INSTANCE|REGEXP
```

#### Vagrant

vagrant help

#### AWS Instances

https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#Instances:

Maintainer: Jon Metzger
Contact: n/a