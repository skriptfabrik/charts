# Sentry Relay Helm Chart

This is an unofficial Helm Chart which provides a Sentry event forwarding and ingestion service.

## Installation

### Add repository

```bash
helm repo add skriptfabrik https://skriptfabrik.github.io/charts
```

### Install chart

```bash
helm install my-sentry-relay skriptfabrik/sentry-relay
```

### Uninstall chart

```bash
helm delete my-sentry-relay
```

To delete the deployment and its history:

```bash
helm delete --purge my-sentry-relay
```
