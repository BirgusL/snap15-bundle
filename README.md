# ESA SNAP 15.0.0 Docker Image

This repository provides a Docker image for **ESA SNAP (SeNtinel Application Platform) 15.0.0**, packaged as a ready-to-use container environment for satellite data processing.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **Docker** (version 20.10 or later)  

## About This Bundle

This Docker image contains a custom bundle of ESA SNAP 15.0.0 with specific dependency updates:

- **Base Version**: ESA SNAP 15.0.0
- **Original Source**: [eomasters-repos/snap-engine](https://github.com/eomasters-repos/snap-engine/tree/master)
- **Bundle Type**: Raw JAR bundle (no pre-configured launcher scripts)

### Custom Dependencies

| Package | Default Version | Updated Version | Reason |
|---------|----------------|-----------------|--------|
| `jackson-core.jar` | 2.19.0 | **2.21.4** | Security fixes |
| `aircompressor.jar` | 0.27 | **2.0.3** | Security fixes |

## Quick Start

### 1. Build the Docker Image

```bash
docker build --no-cache -t snap15 .
```
### 2. Run the Container

```bash
docker run -d --name snap-container snap15 tail -f /dev/null
```

### 3. Access the Container

```bash
docker exec -it snap-container bash
```

### 4. Verify SNAP Installation
Inside the container, test the GPT command:

```bash
gpt -h
```

Expected output: Help menu displaying available SNAP operators and usage instructions
