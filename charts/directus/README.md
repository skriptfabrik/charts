# Directus Helm Chart

This is an unofficial Helm Chart for [Directus](https://directus.io/), the open data platform for headless content
management.

## Installation

### Add repository

```bash
helm repo add skriptfabrik https://skriptfabrik.github.io/charts
```

### Install chart

```bash
helm install my-driectus skriptfabrik/directus
```

### Uninstall chart

```bash
helm delete my-directus
```

To delete the deployment and its history:

```bash
helm delete --purge my-directus
```

## Configuration

The following table lists the configurable parameters of this chart and the default values.

### General
| Parameter            | Description                                                     | Default |
|----------------------|-----------------------------------------------------------------|---------|
| `replicaCount`       | Desired number of controller pods                               | `1`     |
| `imagePullSecrets`   | Name of Secret resource containing private registry credentials | `[]`    |
| `nameOverride`       | Replace the name of the chart                                   | `""`    |
| `fullnameOverride`   | Completely replace the generated name                           | `""`    |
| `podAnnotations`     | Annotations to add to the pods                                  | `{}`    |
| `podSecurityContext` | Security context policies to add to the pods                    | `{}`    |
| `securityContext`    | Security context to add to the container pods                   | `{}`    |
| `resources`          | The resource limits and requested resources for the containers  | `{}`    |
| `nodeSelector`       | Node labels for pod assignment                                  | `{}`    |
| `tolerations`        | Tolerations for pod assignment                                  | `[]`    |
| `affinity`           | Affinity for pod assignment                                     | `{}`    |

### Image

| Parameter          | Description                                                    | Default             |
|--------------------|----------------------------------------------------------------|---------------------|
| `image.registry`   | Container image repository                                     | `directus/directus` |
| `image.pullPolicy` | Container image pull policy                                    | `IfNotPresent`      |
| `image.tag`        | Override the image tag whose default is the chart `appVersion` | `""`                |

### Service Account

| Parameter                    | Description                                 | Default |
|------------------------------|---------------------------------------------|---------|
| `serviceAccount.create`      | Whether a service account should be created | `true`  |
| `serviceAccount.annotations` | Annotations to add to the service account   | `{}`    |
| `serviceAccount.name`        | The name of the service account to use      | `""`    |

### Service

| Parameter      | Description            | Default     |
|----------------|------------------------|-------------|
| `service.type` | Service type to create | `ClusterIP` |
| `service.port` | HTTP service port      | `8055`      |

### Ingress

| Parameter             | Description                                                    | Default                                                                                            |
|-----------------------|----------------------------------------------------------------|----------------------------------------------------------------------------------------------------|
| `ingress.enabled`     | Enable the creation of an Ingress for the service              | `false`                                                                                            |
| `ingress.className`   | Ingress class that will be be used (Kubernetes 1.18+)          | `""`                                                                                               |
| `ingress.annotations` | Additional annotations for the Ingress                         | `{}`                                                                                               |
| `ingress.hosts`       | The list of hosts to be covered with this Ingress              | `[{ "host": "directus.local", "paths": [{ "path": "/", "pathType": "ImplementationSpecific" }] }]` |
| `ingress.tls`         | Enable TLS configuration for the defined hosts of this Ingress | `[]`                                                                                               |

### Autoscaling

| Parameter                                       | Description                            | Default |
|-------------------------------------------------|----------------------------------------|---------|
| `autoscaling.enabled`                           | Enable horizontal pod autoscaler       | `false` |
| `autoscaling.minReplicas`                       | Minimum number of replicas             | `1`     |
| `autoscaling.maxReplicas`                       | Maximum number of replicas             | `100`   |
| `autoscaling.targetCPUUtilizationPercentage`    | Target CPU utilization (percentage)    | `80`    |
| `autoscaling.targetMemoryUtilizationPercentage` | Target memory utilization (percentage) | `80`    |

### Liveness Probe

| Parameter                           | Description                               | Default |
|-------------------------------------|-------------------------------------------|---------|
| `livenessProbe.initialDelaySeconds` | Initial delay of liveness probe (sceonds) | `60`    |

### Readiness Probe

| Parameter                            | Description                                | Default |
|--------------------------------------|--------------------------------------------|---------|
| `readinessProbe.initialDelaySeconds` | Initial delay of readiness probe (seconds) | `60`    |

### Persistence

| Parameter                   | Description                         | Default         |
|-----------------------------|-------------------------------------|-----------------|
| `persistence.enabled`       | Enable persistence                  | `false`         |
| `persistence.annotations`   | Persistent Volume Claim annotations | `{}`            |
| `persistence.accessMode`    | Persistent Volume access mode       | `ReadWriteOnce` |
| `persistence.storageClass`  | Persistent Volume storage class     | `""`            |
| `persistence.existingClaim` | A manually managed claim            | `""`            |
| `persistence.size`          | Size for the Persistent Volume      | `8Gi`           |

### Directus

The configuration of the Directus application itself is based on the [config options](https://docs.directus.io/self-hosted/config-options.html) from the docs.

#### General

| Parameter                         | Description                                                                               | Default  |
|-----------------------------------|-------------------------------------------------------------------------------------------|----------|
| `directus.general.basePath`       | Base path where the API can be reached on the web                                         | `/`      |
| `directus.general.logLevel`       | What level of detail to log                                                               | `info`   |
| `directus.general.logStyle`       | Render the logs human-readable (pretty) or as JSON                                        | `pretty` |
| `directus.general.maxPayloadSize` | Controls the maximum request body size. Accepts number of bytes, or human-readable string | `1mb`    |

#### Database

| Parameter                    | Description                 | Default   |
|------------------------------|-----------------------------|-----------|
| `directus.database.client`   | What database client to use | `sqlite3` |
| `directus.database.host`     | Database host               | `""`      |
| `directus.database.client`   | Database port               | `""`      |
| `directus.database.database` | Database name               | `""`      |
| `directus.database.user`     | Database user               | `""`      |
| `directus.database.password` | Database password           | `""`      |

#### Redis

| Parameter        | Description             | Default |
|------------------|-------------------------|---------|
| `directus.redis` | Redis connection string | `""`    |

#### Security

| Parameter                  | Description                       | Default |
|----------------------------|-----------------------------------|---------|
| `directus.security.key`    | Unique identifier for the project | `""`    |
| `directus.security.secret` | Secret string for the project     | `""`    |

#### CORS

| Parameter               | Description                        | Default |
|-------------------------|------------------------------------|---------|
| `directus.cors.enabled` | Whether to enable the CORS headers | `false` |

#### Rate Limiting

| Parameter                       | Description                                       | Default  |
|---------------------------------|---------------------------------------------------|----------|
| `directus.rateLimiting.enabled` | Whether to enable rate limiting per IP on the API | `false`  |
| `directus.rateLimiting.store`   | Where to store the rate limiter counts            | `memory` |

#### Cache

| Parameter                  | Description                                                            | Default  |
|----------------------------|------------------------------------------------------------------------|----------|
| `directus.cache.enabled`   | Whether data caching is enabled                                        | `false`  |
| `directus.cache.autoPurge` | Automatically purge the data cache on actions that manipulate the data | `false`  |
| `directus.cache.store`     | Where to store the cache data                                          | `memory` |

#### File Storage

| Parameter                         | Description                                    | Default       |
|-----------------------------------|------------------------------------------------|---------------|
| `directus.fileStorage.locations`  | A list of storage locations                    | `[ "local" ]` |
| `directus.fileStorage.gcs.key`    | Google Cloud service account key file contents | `""`          |
| `directus.fileStorage.gcs.bucket` | Google Cloud Storage bucket                    | `""`          |

#### Authentication

| Parameter                                                | Description                                            | Default |
|----------------------------------------------------------|--------------------------------------------------------|---------|
| `directus.authentication.providers`                      | A list of auth providers                               | `[]`    |
| `directus.authentication.disableDefault`                 | Disable the default auth provider                      | `false` |
| `directus.authentication.google.clientID`                | Client identifier for the Google OAuth provider        | `""`    |
| `directus.authentication.google.clientID`                | Client secret for the Google OAuth provider            | `""`    |
| `directus.authentication.google.allowPublicRegistration` | Automatically create accounts for authenticating users | `false` |
| `directus.authentication.google.defaultRoleID`           | A role ID to assign created users                      | `""`    |

#### Admin Account

| Parameter                        | Description                                                      | Default |
|----------------------------------|------------------------------------------------------------------|---------|
| `directus.adminAccount.enabled`  | Whether creating an admin account is enabled                     | `false` |
| `directus.adminAccount.email`    | The email address of the first user that's automatically created | `""`    |
| `directus.adminAccount.password` | The password of the first user that's automatically created      | `""`    |


#### Telemetry

| Parameter                    | Description                                             | Default |
|------------------------------|---------------------------------------------------------|---------|
| `directus.telemetry.enabled` | Allow to collect anonymized data about your environment | `true`  |


#### Extra

| Parameter                       | Description                                              | Default |
|---------------------------------|----------------------------------------------------------|---------|
| `directus.extra.env`            | A map with environment variables                         | `{}`    |
| `directus.extra.secret`         | A map with secret values                                 | `{}`    |
| `directus.extra.existingSecret` | Name of an existing secret to get the secret values from | `""`    |
