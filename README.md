# Jobaance Static Website

A colorful static landing page for **Jobaance** – a finance education and career training platform.


## Deployment

1. Create an S3 bucket named after your domain (e.g., `example.com`).
2. Enable static website hosting and apply a public-read bucket policy.
3. Upload site files using the AWS console or:

   ```bash
   aws s3 sync . s3://example.com
   ```

4. In Route 53, create an alias `A` record pointing to the bucket website endpoint.

### Troubleshooting

- Clear browser caches if updates do not appear.
- DNS changes may take time; verify propagation with tools like `dig` or `nslookup`.

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
