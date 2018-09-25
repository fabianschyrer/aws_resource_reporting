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

####### Setup User Account and Role

# vi ~/.aws/credentials 											# specicy user credentials
# vi ~/.aws/config													# specify IAM role

####### Define Variables

PROFILE=OpsAdmin													# IAM Role (must match IAM role name, specified in ~/.aws/config)
OUTPUT_FORMAT=json													# text, table, json
REPORT_NAME=AWS_Report_AllResources 								# Name of the Report
OUTPUT_DIR=./AWS_Reports											# Output Directory
REGION=ap-southeast-1												# region or loop though all regions (uncomment below)
COST_REPORT_STOP=$(date +%Y-%m-%d)									# Cost and Usage Report Stop Day, e.g. today (not including)
COST_REPORT_START=2018-08-01										# Cost and Usage Report Start Day, e.g. last month (including)
COST_REPORT_DIMENSION=REGION										# e.g. AZ, INSTANCE_TYPE, LINKED_ACCOUNT, OPERATION, PURCHASE_TYPE, REGION, SERVICE, USAGE_TYPE, USAGE_TYPE_GROUP, RECORD_TYPE, OPERATING_SYSTEM, TENANCY, SCOPE, PLATFORM, SUBSCRIPTION_ID, LEGAL_ENTITY_NAME, DEPLOYMENT_OPTION, DATABASE_ENGINE, CACHE_ENGINE, INSTANCE_TYPE_FAMILY
COST_REPORT_GRANULARITY=DAILY 										# e.g. DAILY, WEEKLY, MONTHLY
COST_REPORT_METRICS=UsageQuantity 										# e.g. BlendedCost, UnblendedCost, UsageQuantity, NormalizedUsageAmount, AmortizedCost, NetUnblendedCost

####### EC2 and Base Infrastructure Resources

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

####### Relational DataBase Service (RDS) Resources

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

####### Lambda Resources

echo -e "\n ***** Listing Lambda Functions in region:'$REGION'..."
aws lambda list-functions --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Lambda.Functions.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### S3 Resources

echo -e "\n ***** Listing S3 Buckets in region:'$REGION'..."
aws s3api list-buckets --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.S3.Buckets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### CloudFront Resources

echo -e "\n ***** Listing CloudFront Distributions in region:'$REGION'..."
aws cloudfront list-distributions --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CloudFront.Distributions.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### DynamoDB (nosql) Resources

echo -e "\n ***** Listing DynamoDB Tables in region:'$REGION'..."
aws dynamodb list-tables --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DynamoDB.Tables.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing DynamoDB Backups in region:'$REGION'..."
aws dynamodb list-backups --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DynamoDB.Backups.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### CloudTrail Resources

echo -e "\n ***** Listing CloudTrail Trails in region:'$REGION'..."
aws cloudtrail describe-trails --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CloudTrail.Trails.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### DataBase Migration Service (DMS) Resources

echo -e "\n ***** Listing Database Migration Service (DMS) Attributes in region:'$REGION'..."
aws dms describe-account-attributes --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.Attributes.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service (DMS) Connections in region:'$REGION'..."
aws dms describe-connections --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.Connections.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service (DMS) Endpoints in region:'$REGION'..."
aws dms describe-endpoints --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.Endpoints.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service (DMS) Events in region:'$REGION'..."
aws dms describe-events --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.Events.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service (DMS) Replication Instances in region:'$REGION'..."
aws dms describe-replication-instances --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.ReplicationInstances.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service (DMS) Replication Subnet Groups in region:'$REGION'..."
aws dms describe-replication-subnet-groups --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.ReplicationSubnetGroups.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Database Migration Service (DMS) Replication Tasks in region:'$REGION'..."
aws dms describe-replication-tasks --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.DMS.ReplicationTasks.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### CloudSearch Resources

echo -e "\n ***** Listing CloudSearch Domain Names in region:'$REGION'..."
aws cloudsearch list-domain-names --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CloudSearch.DomainNames.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### CloudWatch Resources

echo -e "\n ***** Listing CloudWatch Dashboards in region:'$REGION'..."
aws cloudwatch list-dashboards --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CloudWatch.Dashboards.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing CloudWatch Metrics in region:'$REGION'..."
aws cloudwatch list-metrics --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CloudWatch.Metrics.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Elastic Container Service (ECR) Resources

echo -e "\n ***** Listing ECR Repositories in region:'$REGION'..."
aws ecr describe-repositories --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ECR.Repositories.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Lightsail Resources

echo -e "\n ***** Listing Lightsail Blueprints in region:'$REGION'..."
aws lightsail get-blueprints --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Lightsail.Blueprints.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Lightsail Bundles in region:'$REGION'..."
aws lightsail get-bundles --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Lightsail.Bundles.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
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

####### ElastiCache Resources

echo -e "\n ***** Listing ElastiCache Cluster in region:'$REGION'..."
aws elasticache describe-cache-clusters --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ElastiCache.Cluster.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing ElastiCache Engine Versions in region:'$REGION'..."
aws elasticache describe-cache-engine-versions --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ElastiCache.EngineVersions.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing ElastiCache Security Groups in region:'$REGION'..."
aws elasticache describe-cache-security-groups --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ElastiCache.SecurityGroups.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing ElastiCache Subnets in region:'$REGION'..."
aws elasticache describe-cache-subnet-groups --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ElastiCache.Subnets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing ElastiCache Events in region:'$REGION'..."
aws elasticache describe-events --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ElastiCache.Events.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing ElastiCache Reserved Cache Nodes in region:'$REGION'..."
aws elasticache describe-reserved-cache-nodes --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ElastiCache.ReservedCacheNodes.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing ElastiCache Snapshots in region:'$REGION'..."
aws elasticache describe-snapshots --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ElastiCache.Snapshots.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### ElasticSearch Resources

echo -e "\n ***** Listing ElasticSearch Domain Names in region:'$REGION'..."
aws es list-domain-names --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ElasticSearch.DomainNames.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing ElasticSearch Versions in region:'$REGION'..."
aws es list-elasticsearch-versions --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ElasticSearch.Versions.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Glue Resources

echo -e "\n ***** Listing Glue Connections in region:'$REGION'..."
aws glue get-connections --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Glue.Connections.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Glue Databases in region:'$REGION'..."
aws glue get-databases --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Glue.Databases.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Glue Jobs in region:'$REGION'..."
aws glue get-jobs --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Glue.Jobs.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Glue Triggers in region:'$REGION'..."
aws glue get-triggers --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Glue.Triggers.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Key Management System (KMS) Resources

echo -e "\n ***** Listing Key Management Service (KMS) Keys in region:'$REGION'..."
aws kms list-keys --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.KMS.Keys.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Key Management Service (KMS) Aliases in region:'$REGION'..."
aws kms list-aliases --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.KMS.Aliases.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Kinesis Resources

echo -e "\n ***** Listing Kinesis Streams in region:'$REGION'..."
aws kinesis list-streams --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Kinesis.Streams.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Route53 (DNS) Resources

echo -e "\n ***** Listing Route53 (DNS) Geo Locations in region:'$REGION'..."
aws route53 list-geo-locations --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Route53.GeoLocations.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Route53 (DNS) Hosted Zones in region:'$REGION'..."
aws route53 list-hosted-zones --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Route53.HostedZones.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Route53 (DNS) Health Checks in region:'$REGION'..."
aws route53 list-health-checks --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Route53.HealthChecks.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Route53 (DNS) Hosted Zones by Name in region:'$REGION'..."
aws route53 list-hosted-zones-by-name --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Route53.HostedZonesByName.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Route53 (DNS) Traffic Policies in region:'$REGION'..."
aws route53 list-traffic-policies --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Route53.TrafficPolicies.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Route53 (DNS) Traffic Policy Instances in region:'$REGION'..."
aws route53 list-traffic-policy-instances --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.Route53.TrafficPolicyInstances.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Simple Notification Service (SNS) Resources

echo -e "\n ***** Listing Simple Notification Service (SNS) Topics in region:'$REGION'..."
aws sns list-topics --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.SNS.Topics.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Simple Notification Service (SNS) Subscriptions in region:'$REGION'..."
aws sns list-subscriptions --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.SNS.Subscriptions.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Simple Notification Service (SNS) Platform Applications in region:'$REGION'..."
aws sns list-platform-applications --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.SNS.PlatformApplications.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Simple Notification Service (SNS) Phone Numbers opted-out in region:'$REGION'..."
aws sns list-phone-numbers-opted-out --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.SNS.PhoneNumbersOptedOut.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Simple Queue Service (SQS) Resources

echo -e "\n ***** Listing Simple Queue Service (SQS) Queues in region:'$REGION'..."
aws sqs list-queues --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.SQS.Queues.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Web Application Firewall (WAF) Resources

echo -e "\n ***** Listing Web Application Firewall (WAF) Byte Match Sets in region:'$REGION'..."
aws waf list-byte-match-sets --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.ByteMatchSets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) Geo Match Sets in region:'$REGION'..."
aws waf list-geo-match-sets --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.GeoMatchSets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) IP Sets in region:'$REGION'..."
aws waf list-ip-sets --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.IPsets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) Rate Based Rules in region:'$REGION'..."
aws waf list-rate-based-rules --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.RateBasedRules.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) REGEX Match Sets in region:'$REGION'..."
aws waf list-regex-match-sets --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.REGEXmatchSets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) REGEX Pattern Sets in region:'$REGION'..."
aws waf list-regex-pattern-sets --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.REGEXpatternSets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) Rule Groups in region:'$REGION'..."
aws waf list-rule-groups --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.RuleGroups.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) Rules in region:'$REGION'..."
aws waf list-rules --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.Rules.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) Size Constraint Sets in region:'$REGION'..."
aws waf list-size-constraint-sets --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.SizeConstraintSets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) SQL Injection Match Sets in region:'$REGION'..."
aws waf list-sql-injection-match-sets --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.SQLinjectionMatchSets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) Subscribed Rule Groups in region:'$REGION'..."
aws waf list-subscribed-rule-groups --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.SubscribedRuleGroups.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) Web ACLs in region:'$REGION'..."
aws waf list-web-acls --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.WebACLs.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Web Application Firewall (WAF) XSS Match Sets in region:'$REGION'..."
aws waf list-xss-match-sets --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.WAF.XSSmatchSets.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Elastic Load Balancer (ELB) Resources

echo -e "\n ***** Listing Elastic Load Balancer (ELB) Account Limits in region:'$REGION'..."
aws elb describe-account-limits --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ELB.AccountLimits.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Elastic Load Balancers (ELB) in region:'$REGION'..."
aws elb describe-load-balancers --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ELB.ELBs.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Elastic Load Balancer (ELB) Policies in region:'$REGION'..."
aws elb describe-load-balancer-policies --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ELB.Policies.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Elastic Load Balancer (ELB) Types in region:'$REGION'..."
aws elb describe-load-balancer-policy-types --region $REGION --profile $PROFILE --output=$OUTPUT_FORMAT > ${REPORT_NAME}.ELB.Types.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Cost Explorer (ce)

echo -e "\n ***** Listing Cost Explorer Cost and Usage in region:'$REGION'..."
aws ce get-cost-and-usage --region $REGION --profile $PROFILE --time-period Start=$COST_REPORT_START,End=$COST_REPORT_STOP --metrics $COST_REPORT_METRICS --granularity $COST_REPORT_GRANULARITY --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CostExplorer.CostsAndUsage.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Cost Explorer Dimension Values in region:'$REGION'..."
aws ce get-dimension-values --region $REGION --profile $PROFILE --time-period Start=$COST_REPORT_START,End=$COST_REPORT_STOP --dimension $COST_REPORT_DIMENSION --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CostExplorer.DimensionValues.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

echo -e "\n ***** Listing Cost Explorer Tags in region:'$REGION'..."
aws ce get-tags --region $REGION --profile $PROFILE --time-period Start=$COST_REPORT_START,End=$COST_REPORT_STOP --output=$OUTPUT_FORMAT > ${REPORT_NAME}.CostExplorer.Tags.${PROFILE}.${REGION}.${OUTPUT_FORMAT}
echo

####### Organize Output

mkdir AWS_Reports 2> /dev/null
cd AWS_Reports
mkdir $(date +%Y-%m-%d)_${REPORT_NAME}
cd ..
mv -f ${REPORT_NAME}*.${OUTPUT_FORMAT} $OUTPUT_DIR/$(date +%Y-%m-%d)_${REPORT_NAME}
zip -r $(date +%Y-%m-%d)_${REPORT_NAME}.zip $OUTPUT_DIR/$(date +%Y-%m-%d)_${REPORT_NAME}
echo
echo "***** Report has been created successfully. The Report has been zipped"
echo "***** Filename:" $(date +%Y-%m-%d)_${REPORT_NAME}.zip
echo

####### Cleanup JSON Files

rm -Rf $OUTPUT_DIR/$(date +%Y-%m-%d)_${REPORT_NAME}
rm -Rf $OUTPUT_DIR





