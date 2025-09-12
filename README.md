# Jobaance Static Website

A colorful static landing page for **Jobaance** – a finance education and career training platform.

## Deployment (S3 + CloudFront + Route 53)

The repository includes a CloudFormation template and helper script to deploy the
site to Amazon S3 with a CloudFront distribution and Route 53 record.

### Prerequisites

1. An AWS account with the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configured.
2. A registered domain in Route 53 (e.g., `example.com`).
3. An ACM certificate for the domain in `us-east-1`.

### Steps

1. **Deploy infrastructure & upload files**

   ```bash
   ./deploy.sh example.com arn:aws:acm:us-east-1:111111111111:certificate/abcd-1234
   ```

   This command:
   - Creates an S3 bucket (`example.com`) configured for static website hosting
   - Creates a CloudFront distribution using the certificate
   - Creates a Route 53 alias record pointing to CloudFront
   - Syncs local website files to S3

2. **Wait for CloudFront** – the distribution can take ~10–15 minutes to become active.
3. **Browse** `https://example.com` to see the site.

To update the site later, edit the files and rerun the `aws s3 sync` portion of
`deploy.sh` or use the script again.

### Manual Upload

If you prefer a manual approach:

```bash
aws s3 cp index.html s3://example.com
aws s3 cp style.css s3://example.com
aws s3 cp script.js s3://example.com
```

Make sure the bucket policy allows public reads or that CloudFront has access.

## Project Structure

```
├── index.html       # Landing page markup
├── style.css        # Styling
├── script.js        # Small JS for nav + animations
├── infra
│   └── cloudformation.yaml  # S3/CloudFront/Route53 infrastructure
└── deploy.sh        # Helper script to deploy via AWS CLI
```

## License

[MIT](LICENSE)
