 #!/bin/bash

#########################################################################################################################
#																														#
#       Title:                 	AWS_reporting_all_resources_per_region.sh                                               #
#       Purpose:                Gather AWS resources in one specified region and write output to file 	                #
#       Author:                 Fabian Alexander Schyrer, Central Group                                               	#
#       Poasition:              General Manager, Cloud Engineering, CTO office                                        	#
#       Date created:           2018-09-25                                                                            	#
#                                                                                                                     	#
#########################################################################################################################


# vi ~/.aws/credentials 											# specicy user credentials
# vi ~/.aws/config													# specify IAM role

PROFILE=OpsAdmin													# IAM Role (must match IAM role name, specified in ~/.aws/config)
OUTPUT_FORMAT=json													# text, table, json
REPORT_NAME=AWS_Report_AllResources 								# Name of the Report
OUTPUT_DIR=./AWS_Reports											# Output Directory
REGION=ap-southeast-1												# region or loop though all regions (uncomment below)


echo -e "\n ***** Listing EC2 Instances in region:'$REGION'..."
aws ec2 describe-instances --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.EC2.Intances.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing VPCs in region:'$REGION'..."
aws ec2 describe-vpcs --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.VPCs.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Subnets in region:'$REGION'..."
aws ec2 describe-vpcs --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Subnets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Hosts in region:'$REGION'..."
aws ec2 describe-hosts --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Hosts.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Security Groups in region:'$REGION'..."
aws ec2 describe-security-groups --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.SecurityGroups.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Images in region:'$REGION'..."
aws ec2 describe-images --region $REGION --profile $PROFILE --owner self --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Images.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Tags in region:'$REGION'..."
aws ec2 describe-tags --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.EC2.Tags.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing IP Addresses in region:'$REGION'..."
aws ec2 describe-addresses --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.EC2.IPaddresses.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Reserved Instances in region:'$REGION'..."
aws ec2 describe-reserved-instances --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ReservedInstances.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Snapshots in region:'$REGION'..."
aws ec2 describe-snapshots --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Snapshots.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Launch Templates in region:'$REGION'..."
aws ec2 describe-launch-templates --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.LaunchTemplates.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing RDS DB Instances in region:'$REGION'..."
aws rds describe-db-instances --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.RDS.DB.Instances.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing RDS DB Instances in region:'$REGION'..."
aws rds describe-db-instances --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.RDS.DB.Instances.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing RDS Security Groups in region:'$REGION'..."
aws rds describe-db-security-groups --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.RDS.SecurityGroups.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing RDS DB Snapshots in region:'$REGION'..."
aws rds describe-db-snapshots --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.RDS.DB.Snapshots.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing RDS Reserved DB Instances in region:'$REGION'..."
aws rds describe-reserved-db-instances --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.RDS.Reserved.DB.Instances.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing RDS DB Clusters in region:'$REGION'..."
aws rds describe-db-clusters --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.RDS.DB.Clusters.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Lambda Functions in region:'$REGION'..."
aws lambda list-functions --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Lambda.Functions.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing S3 Buckets in region:'$REGION'..."
aws s3api list-buckets --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.S3.Buckets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing CloudFront Distributions in region:'$REGION'..."
aws cloudfront list-distributions --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CloudFront.Distributions.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing DynamoDB Tables in region:'$REGION'..."
aws dynamodb list-tables --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DynamoDB.Tables.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing DynamoDB Backups in region:'$REGION'..."
aws dynamodb list-backups --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DynamoDB.Backups.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing CloudTrail Trails in region:'$REGION'..."
aws cloudtrail describe-trails --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CloudTrail.Trails.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service Attributes in region:'$REGION'..."
aws dms describe-account-attributes --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.Attributes.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service Connections in region:'$REGION'..."
aws dms describe-connections --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.Connections.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service Endpoints in region:'$REGION'..."
aws dms describe-endpoints --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.Endpoints.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service Events in region:'$REGION'..."
aws dms describe-events --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.Events.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service Replication Instances in region:'$REGION'..."
aws dms describe-replication-instances --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.ReplicationInstances.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service Replication Subnet Groups in region:'$REGION'..."
aws dms describe-replication-subnet-groups --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.ReplicationSubnetGroups.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service Replication Tasks in region:'$REGION'..."
aws dms describe-replication-tasks --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.ReplicationTasks.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing CloudSearch Domain Names in region:'$REGION'..."
aws cloudsearch list-domain-names --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CloudSearch.DomainNames.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing CloudWatch Dashboards in region:'$REGION'..."
aws cloudwatch list-dashboards --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CloudWatch.Dashboards.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing CloudWatch Metrics in region:'$REGION'..."
aws cloudwatch list-metrics --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CloudWatch.Metrics.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing ECR Images in region:'$REGION'..."
aws ecr list-images --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ECR.Images.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing ECR Repositories in region:'$REGION'..."
aws ecr describe-repositories --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ECR.Repositories.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Lightsail Blueprints in region:'$REGION'..."
aws lightsail get-blueprints --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Lightsail.Blueprints.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Lightsail Bundles in region:'$REGION'..."
aws lightsail get-bundles --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Lightsail.Bundles.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Lightsail Domains in region:'$REGION'..."
aws lightsail get-domains --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Lightsail.Domains.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Lightsail Instances in region:'$REGION'..."
aws lightsail get-instances --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Lightsail.Instances.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Lightsail Load Balancers in region:'$REGION'..."
aws lightsail get-load-balancers --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Lightsail.LoadBalancers.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Lightsail static IPaddresses in region:'$REGION'..."
aws lightsail get-static-ips --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Lightsail.staticIPs.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo












mkdir AWS_Reports 2> /dev/null
cd AWS_Reports
mkdir $(date +%Y-%m-%d)_${REPORT_NAME}
cd ..
mv -f ${REPORT_NAME}*.${OUTPUT_FORMAT} $OUTPUT_DIR/$(date +%Y-%m-%d)_${REPORT_NAME}







