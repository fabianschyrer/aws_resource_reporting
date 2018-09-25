 #!/bin/bash

#########################################################################################################################
#																														#
#       Title:                 	AWS_reporting_EC2_Tags.sh  		                                                      	#
#       Purpose:                Gather AWS EC2 Tags and write output to file		 	                            	#
#       Author:                 Fabian Alexander Schyrer, Central Group                                               	#
#       Poasition:              General Manager, Cloud Engineering, CTO office                                        	#
#       Date created:           2018-09-25                                                                            	#
#                                                                                                                     	#
#########################################################################################################################


# vi ~/.aws/credentials 											# specicy user credentials
# vi ~/.aws/config													# specify IAM role

PROFILE=OpsAdmin													# IAM Role (must match IAM role name, specified in ~/.aws/config)
OUTPUT_FORMAT=json													# text, table, json
REPORT_NAME=AWS_reporting_EC2_Tags									# Name of the Report
OUTPUT_DIR=./AWS_Reports											# Output Directory
#REGION=ap-southeast-1												# region or loop though all regions (uncomment below)


for REGION in `aws ec2 describe-regions --output text | cut -f3`
do
    echo -e "\n ***** Listing EC2 Tags in region:'$REGION'..."
    aws ec2 describe-tags --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
done


mkdir AWS_Reports 2> /dev/null
cd AWS_Reports
mkdir $(date +%Y-%m-%d)_${REPORT_NAME}
cd ..
mv -f ${REPORT_NAME}*.${OUTPUT_FORMAT} $OUTPUT_DIR/$(date +%Y-%m-%d)_${REPORT_NAME}
