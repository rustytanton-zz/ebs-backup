Amazon EC2 Daily Linux Volume Snapshots
=======================================

Finds all attached EBS volumes, creates snapshots.

Installation
------------
Presuming you already have an AWS account and an EC2 AMI running Linux:
* Install floodfx's [aws-tools](https://github.com/floodfx/aws-tools) on your server. Make sure the following environment variables are available when the script runs (this should be done after installing aws-tools):
	* `AWS_ACCESS_KEY_ID` - your AWS access key
	* `AWS_SECRET_ACCESS_KEY` - your AWS access key
	* `EC2_CERT` - path to your private certificate
	* `EC2_PRIVATE_KEY` - path to your private key
	* `AWS_TOOLS_HOME` - path to aws-tools
* Clone this repo somewhere on the AMI

Usage
-----
Set up a cron job to run the backup script from this repo daily. 

Here is an example crontab, it sets environment variables from ~/.bash_profile before running:

	@daily . $HOME/.bash_profile; /path/to/ec2-daily-backup/backup.sh