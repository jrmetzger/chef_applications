# chef_applications

Installation of Application using Chef and applying STIG compliance standards

## Setup

https://cinc.sh

```
bash setup.sh
```

Redhat Credentials:
https://www.redhat.com/en

```
$env:REDHAT_USERNAME='username'
$env:REDHAT_PASSWORD='password'
```

## Run

```
./kitchen.sh list
./kitchen.sh converge
./kitchen.sh verify
./kitchen.sh destroy
```
