# SJSU Mentor Match — AWS deployment package

site/       static website -> S3 bucket
backend/    index.mjs -> AWS Lambda (Function URL) + DynamoDB
setup-aws.sh   one-time setup of everything (S3, DynamoDB, IAM role, Lambda, URL, upload)
update.sh      push changes later:  bash update.sh site | api
teardown.sh    delete everything

Full walkthrough: see the "Deploying the SJSU Mentor Match Site on AWS S3" doc.
Demo mode: leave API_URL empty in site/config.js and open site/index.html locally.
Never commit aws-outputs.txt (it holds your admin key).
