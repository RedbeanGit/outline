# Outline Helm Chart

This Helm chart deploys the Outline wiki system on a Kubernetes cluster using the Helm package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0

## Installing the Chart

To install the chart with the release name `my-outline`:

```bash
helm repo add outline https://redbeangit.github.io/outline
helm install my-outline outline/outline
```

## Uninstalling the Chart

To uninstall/delete the `my-outline` deployment:

```bash
helm delete my-outline
```

This command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Outline chart and their default values.

| Parameter                                   | Description                                      | Default                   |
| ------------------------------------------- | ------------------------------------------------ | ------------------------- |
| `replicaCount`                              | Number of Outline replicas                       | `1`                       |
| `image.repository`                          | Outline image name                               | `outlinewiki/outline`     |
| `image.pullPolicy`                          | Image pull policy                                | `IfNotPresent`            |
| `image.tag`                                 | Image tag                                        | `""` (Uses appVersion)    |
| `imagePullSecrets`                          | Specify docker-registry secret names as an array | `[]`                      |
| `nameOverride`                              | String to partially override outline.fullname    | `""`                      |
| `fullnameOverride`                          | String to fully override outline.fullname        | `""`                      |
| `serviceAccount.create`                     | Specifies whether a service account should be created | `true`                |
| `serviceAccount.annotations`                | Service Account annotations                      | `{}`                      |
| `podAnnotations`                            | Annotations to add to pods                       | `{}`                      |
| `service.type`                              | Kubernetes Service type                          | `ClusterIP`               |
| `service.port`                              | Service port                                     | `80`                      |
| `ingress.enabled`                           | Enable ingress controller support                | `false`                   |
| `ingress.hostname`                          | Hostname to your Outline installation            | `outline.local`           |
| `ingress.tls`                               | Enable TLS configuration for the hostname        | `false`                   |
| `postgresql.enabled`                        | Use external PostgreSQL                          | `true`                    |
| `postgresql.auth.username`                  | PostgreSQL username                              | `outline`                 |
| `postgresql.auth.password`                  | PostgreSQL password                              | `outline`                 |
| `postgresql.auth.database`                  | PostgreSQL database                              | `outline`                 |
| `postgresql.auth.existingSecret`            | Use an existing secret for PostgreSQL credentials | `""`                     |
| `redis.enabled`                             | Use external Redis                               | `true`                    |
| `minio.enabled`                             | Use MinIO for storage                            | `true`                    |
| `minio.defaultBuckets`                      | Default MinIO buckets (comma separated values)   | `outline`                 |
| `secretKey`                                 | Secret key for Outline                           | `""`                      |
| `utilsSecretKey`                            | Secret key for Outline utilities                 | `""`                      |
| `existingSecret`                            | Use an existing secret for Outline secrets       | `""`                      |
| `secretKeys.secretKey`                      | Key of the secret key for Outline in secret      | `"secret-key"`            |
| `secretKeys.utilsSecretKey`                 | Key of the secret key for Outline utilities in secret | `"utils-secret-key"` |
| `databaseHost`                              | Use an external database host                    | `""`                      |
| `databasePort`                              | Use an external database port                    | `5432`                    |
| `databaseConnectionPoolMin`                 | Minimum number of connections in the pool        | `""`                      |
| `databaseConnectionPoolMax`                 | Maximum number of connections in the pool        | `""`                      |
| `collaborationServerUrl`                    | Collaboration server URL                         | `""`                      |
| `fileStorageUploadMaxSize`                  | Maximum file upload size                         | `""`                      |
| `fileStorageWorkspaceImportMaxSize`         | Maximum workspace import size                    | `""`                      |
| `fileStorageBucketName`                     | MinIO bucket name                                | `"outline"`               |
| `redisHost`                                 | Use an external Redis host                       | `""`                      |
| `redisPort`                                 | Use an external Redis port                       | `6379`                    |
| `auth.google.clientId`                      | Google OAuth Client ID                           | `""`                      |
| `auth.google.clientSecret`                  | Google OAuth Client Secret                       | `""`                      |
| `auth.google.existingSecret`                | Use an existing secret for Google OAuth credentials | `""`                   |
| `auth.google.secretKeys.clientId`           | Key of the Google OAuth Client ID in secret      | `"client-id"`             |
| `auth.google.secretKeys.clientSecret`       | Key of the Google OAuth Client Secret in secret  | `"client-secret"`         |

Refer to the `values.yaml` file for a more detailed and complete list of possible configuration options.

## Persistence

The Outline chart mounts a Persistent Volume for PostgreSQL, Redis, and MinIO. You need to ensure that persistent volume claims are available and their access modes and size match your needs.

## Customization

You can further customize the configuration by editing the `values.yaml` file or specifying each parameter using the `--set key=value[,key=value]` argument to `helm install`.

## Contributing

Contributions are welcome! Feel free to submit pull requests or file issues on the GitHub repository.
