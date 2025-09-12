# Jobaance Static Website

A colorful static landing page for **Jobaance** – a finance education and career training platform.

## Deployment (S3 + Route 53)

The repository includes a helper script to deploy the site directly to Amazon S3
and create a Route 53 record.

### Prerequisites

1. An AWS account with the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configured.
2. A registered domain in Route 53 (e.g., `example.com`).

### Steps

1. **Deploy infrastructure & upload files**

   ```bash
   ./deploy.sh example.com
   ```

   This command:
   - Creates an S3 bucket (`example.com`) configured for static website hosting
   - Applies a public-read bucket policy
   - Creates a Route 53 alias record pointing to the bucket website endpoint
   - Syncs local website files to S3

2. **Browse** `http://example.com` to see the site.

To update the site later, edit the files and rerun the `aws s3 sync` portion of
`deploy.sh` or use the script again.

### Manual Upload

If you prefer a manual approach:

```bash
aws s3 cp index.html s3://example.com
aws s3 cp style.css s3://example.com
aws s3 cp script.js s3://example.com
```

Make sure the bucket policy allows public reads.

## Project Structure

```
├── index.html       # Landing page markup
├── style.css        # Styling
├── script.js        # Small JS for nav + animations
├── infra
│   └── cloudformation.yaml  # S3/Route53 infrastructure
└── deploy.sh        # Helper script to deploy via AWS CLI
```

## License

[MIT](LICENSE)
