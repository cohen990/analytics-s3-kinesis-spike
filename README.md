This is a spike demonstrating a simple way to get analytics data into s3 so that it can be ingested into the data lake.

In order to deploy the infrastructure,

`cd infra`
`terraform init`
`terraform plan`
`terraform apply`

In order to deploy the app,

`cd ..`
`npm install`
`npm run deploy`

To run it, find the app in AWS Lambda and Test it. That'll drop some text into the kinesis firehose which will find its way into s3 afterwards.